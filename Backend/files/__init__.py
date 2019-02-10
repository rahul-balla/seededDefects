import os
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import Index, func
from flask_bootstrap import Bootstrap
from flask_bcrypt import Bcrypt
from flask_mail import Mail
import time
from flask_login import LoginManager, UserMixin, login_user, login_required, logout_user, current_user
from datetime import datetime
from itsdangerous import TimedJSONWebSignatureSerializer as Serializer

from flask import Flask, render_template, request, redirect, url_for, session, flash

os.environ['OAUTHLIB_INSECURE_TRANSPORT'] = '1'
os.environ['OAUTHLIB_RELAX_TOKEN_SCOPE'] = '1'
app = Flask(__name__)
Bootstrap(app)

app.config['SECRET_KEY'] = 'THIS_IS_SECRET'
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://casinoroyale:tindents@tindents.csu6kcem8ioz.us-east-2.rds.amazonaws.com/casinoroyale'

db = SQLAlchemy(app)
bcrypt = Bcrypt(app)
login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = '/'


app.secret_key = "tindents"

@login_manager.user_loader
def load_user(user_id):
    return users.query.get(int(user_id))

###################################################### TABLES ##############################################
class users(UserMixin, db.Model):
    id = db.Column(db.Integer, primary_key=True, nullable = False)
    username = db.Column(db.String(50), nullable=False)
    email = db.Column(db.String(50), nullable=False)
    password = db.Column(db.String(50), nullable=False)
    account_type = db.Column(db.String(10), nullable = False)
    fullName = db.Column(db.String(50))

    def __repr__(self):
        return "users('{self.username}', {self.email}', {self.password}', {self.fullName}')"





################################################ ROUTES ########################################################
@app.route("/createAccount", methods=['GET', 'POST'])
def createAccount():
	content = request.json
	print(content)

    	user = users(username = "rahul", password = "balla", email = "rahul@gmail.com", account_type = "student", fullName = "rahul balla")
    	db.session.add(user)
    	db.session.commit()
    
    
    	print("accout has been added to database")
