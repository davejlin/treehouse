# -*- coding: utf-8 -*-
# Generated by Django 1.10.4 on 2017-01-03 19:30
from __future__ import unicode_literals

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('songs', '0001_initial'),
    ]

    operations = [
        migrations.RenameField(
            model_name='song',
            old_name='duration',
            new_name='length',
        ),
    ]
