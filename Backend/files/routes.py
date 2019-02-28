import secrets
import os
from flask import Flask, render_template, request, redirect, url_for, session, flash, jsonify
import json
from pusher import Pusher
from files import app, db, bcrypt, mail
from files.form import (LoginForm, RegisterForm, RecipeForm, RequestResetForm, ResetPasswordForm,
                        UpdateProfileForm, PostForm, PostFormHungryFor, PostFormCurrentlyEating,
                        RecipeSearchForm, RecipeSearchForm, CommentForm, FindFriends)
from files.__init__ import users
from flask_login import login_user, current_user, logout_user, login_required
from flask_mail import Mail, Message
from werkzeug.security import generate_password_hash, check_password_hash
from oauthlib.oauth2.rfc6749.errors import InvalidClientIdError
from itsdangerous import TimedJSONWebSignatureSerializer as Serializer
import re
from sqlalchemy import func

app = Flask(__name__)


