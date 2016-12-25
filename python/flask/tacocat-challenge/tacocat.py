from flask import (Flask, g, render_template, redirect,
                    url_for, flash)
from flask_bcrypt import check_password_hash
from flask_login import (LoginManager, login_user, logout_user,
                         login_required, current_user)

import models
import forms

DEBUG = True
PORT = 8000
HOST = '0.0.0.0'

app = Flask(__name__)
app.secret_key = 'blaah1234randomkey321blaah987654321!~`{}argoi'

login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = 'login'

@login_manager.user_loader
def load_user(userid):
    try:
        return models.User.get(models.User.id == userid)
    except models.DoesNotExist:
        return None

@app.before_request
def before_request():
    g.db = models.DATABASE
    g.db.connect()
    g.user = current_user

@app.after_request
def after_request(response):
    g.db.close()
    return response

@app.route('/register', methods=('GET', 'POST'))
def register():
    form = forms.RegisterForm()
    if form.validate_on_submit():
        models.User.create_user(
            email=form.email.data,
            password=form.password.data
        )
        flash("Yay, you registered!", "success")
        return redirect(url_for('index'))
    return render_template('register.html', form=form)

@app.route('/login', methods=('GET', 'POST'))
def login():
    form = forms.LoginForm()
    if form.validate_on_submit():
        try:
            user = models.User.get(models.User.email == form.email.data)
        except:
            flash("Your email or password doesn't match!", "error")
        else:
            if check_password_hash(user.password, form.password.data):
                login_user(user)
                flash("You've been logged in!", "success")
                return redirect(url_for('index'))
            else:
                flash("Your email or password doesn't match!", "error")
    return render_template('login.html', form=form)

@app.route('/logout')
@login_required
def logout():
    logout_user()
    flash("You've been logged out!  Come back soon!", "success")
    return redirect(url_for('index'))

@app.route('/taco', methods=('GET', 'POST'))
@login_required
def taco():
    form = forms.TacoForm()
    if form.validate_on_submit():
        models.Taco.create(
            user=g.user._get_current_object(),
            protein=form.protein.data.strip(),
            shell=form.shell.data.strip(),
            cheese=form.cheese.data,
            extras=form.extras.data.strip()
        )
        flash("Taco ordered! Thanks!", "success")
        return redirect(url_for('index'))
    return render_template('taco.html', form=form)

@app.route('/')
def index():
    tacos = models.Taco.select()
    return render_template('index.html', tacos=tacos)

if __name__ == '__main__':
    models.initialize()
    try:
        models.User.create_user(
            email='email@email.com',
            password='password'
        )
    except ValueError:
        pass
    app.run(debug=DEBUG, host=HOST, port=PORT)
