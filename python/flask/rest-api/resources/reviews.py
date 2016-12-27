from flask import jsonify, Blueprint, abort

from flask_restful import (Resource, Api, reqparse, inputs, url_for,
                           fields, marshal, marshal_with)

import models

review_fields = {
    'id': fields.Integer,
    'for_course': fields.String,
    'rating': fields.Integer,
    'comment': fields.String(default=''),
    'created_at': fields.DateTime
}

def add_course(review):
    review.for_course = url_for('resources.courses.course', id=review.course.id)
    return review

def review_or_404(review_id):
    try:
        review = models.Review.get(models.Review.id==review_id)
    except models.Review.DoesNotExist:
        abort(404)
    else:
        return review

class ReviewList(Resource):
    def __init__(self):
        self.reqparse = reqparse.RequestParser()
        self.reqparse.add_argument(
            'course',
            type=inputs.positive,
            required=True,
            help='No course provided',
            location=['form', 'json']
        )
        self.reqparse.add_argument(
            'rating',
            required=True,
            type=inputs.int_range(1,5),
            help='No rating provided',
            location=['form', 'json'],
        )
        self.reqparse.add_argument(
            'comment',
            required=False,
            nullable=True,
            location=['form', 'json'],
            default=''
        )
        super().__init__()

    def get(self):
        reviews = [marshal(add_course(review), review_fields) for review in models.Review.select()]
        return {'reviews': reviews}

    @marshal_with(review_fields)
    def post(self):
        args = self.reqparse.parse_args()
        review = models.Review.create(**args)
        return (add_course(review), 201,
                {'Location': url_for('resources.reviews.review', id=review.id)})

class Review(Resource):
    def __init__(self):
        self.reqparse = reqparse.RequestParser()
        self.reqparse.add_argument(
            'course',
            type=inputs.positive,
            required=True,
            help='No course provided',
            location=['form', 'json']
        )
        self.reqparse.add_argument(
            'rating',
            type=inputs.int_range(1, 5),
            required=True,
            help='No rating provided',
            location=['form', 'json']
        )
        self.reqparse.add_argument(
            'comment',
            required=False,
            nullable=True,
            location=['form', 'json'],
            default=''
        )
        super().__init__()

    @marshal_with(review_fields)
    def get(self, id):
        return add_course(review_or_404(id))

    @marshal_with(review_fields)
    def put(self, id):
        args = self.reqparse.parse_args()
        review = review_or_404(id)
        query = review.update(**args)
        query.execute()
        review = add_course(review_or_404(id))
        return (review, 200,
                {'Location': url_for('resources.reviews.review', id=id)})

    def delete(self, id):
        review = review_or_404(id)
        query = review.delete()
        query.execute()
        return '', 204, {'Location': url_for('resoures.reviews.reviews')}

reviews_api = Blueprint('resources.reviews', __name__)
api = Api(reviews_api)
api.add_resource(
    ReviewList,
    '/reviews',
    endpoint='reviews'
)
api.add_resource(
    Review,
    '/review/<int:id>',
    endpoint='review'
)