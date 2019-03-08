import os
from flask import Flask, jsonify, json
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


userid = 0
accountType = ""

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


class matches(UserMixin, db.Model):
    id = db.Column(db.Integer, primary_key=True, nullable = False)
    student_id = db.Column(db.Integer)
    tutor_id = db.Column(db.Integer)
    student_swipe = db.Column(db.Integer)
    tutor_swipe = db.Column(db.Integer)


################################################ ROUTES ########################################################
@app.route("/createAccount", methods=['GET', 'POST'])
def createAccount():
	content = request.json

    	user = users(username = content["username"], password = content["password"], email = content["email"], account_type = content["account_type"], fullName = content["name"])
    	db.session.add(user)
    	db.session.commit()
    
    
    	print("accout has been added to database")

    	return jsonify({'success' : 1})

@app.route("/login", methods=['GET', 'POST'])
def login():
    content = request.json
        
    user = users.query.filter_by(email=content["email"]).first()
    if user.password == content["password"]:
    	global userid
    	userid = user.id

        global accountType
        accountType = user.account_type

        return jsonify({'success' : 1})
    else:
        return jsonify({'success' : 0})




@app.route("/profile", methods=['GET', 'POST'])
def profile():
    user = users.query.filter_by(id = userid).first()



    return jsonify({'username' : user.username, 'email' : user.email, 'account_type' : user.account_type, 'fullName' : user.fullName})


@app.route("/settings", methods=['GET', 'POST'])
def settings():
    content = request.json

    db.engine.execute("UPDATE users SET settings = %s WHERE id = %s", str(content), userid)

    return jsonify({'success' : 1})
    

@app.route("/feed", methods=['GET', 'POST'])
def feed():
    
    userDict = []

    if accountType = "student":
        feed = users.query.filter_by(account_type = "tutor")
        for x in feed:
            matchCheck = db.engine.execute("SELECT COUNT(id) FROM matches WHERE student_id = %s and tutor_id = %s", userid,x.id)
            if matchCheck == 0:
                dd = {'username' : x.username, 'userid' : x.id, 'email':x.email, 'fullName':x.fullName}
                userDict.append(dd)
    else:
        feed = users.query.filter_by(account_type = "student")
        for x in feed:
            matchCheck = db.engine.execute("SELECT COUNT(id) FROM matches WHERE student_id = %s and tutor_id = %s", x.id, userid)
            if matchCheck == 0:
                dd = {'username' : x.username, 'userid' : x.id, 'email':x.email, 'fullName':x.fullName}
                userDict.append(dd)
        
    return jsonify({'feed': userDict})


@app.route("/rightSwipe", methods=['GET', 'POST'])
def rightSwipe():
    content = request.json


    matchCheck = db.engine.execute("SELECT COUNT(id) FROM matches WHERE student_id = %s and tutor_id = %s", userid,content["swipedId"])
    matchCheck2 = db.engine.execute("SELECT COUNT(id) FROM matches WHERE tutor_id = %s and student_id = %s", userid,content["swipedId"])


    if matchCheck == 0 and matchCheck2 == 0:
        print("no entry in table")
        if accountType == "student":
            newEnt = matches(student_id = userid, tutor_id = content["swipedId"],student_swipe = 1, tutor_swipe = 0)
            db.session.add(newEnt)
    	    db.session.commit()
        
        else:
            newEnt = matches(student_id = content["swipedId"], tutor_id = userid, student_swipe = 0, tutor_swipe = 1)
            db.session.add(newEnt)
    	    db.session.commit()
    else:
        if accountType == "student":
            db.engine.execute("UPDATE matches SET student_swipe = %s WHERE student_id = %s AND tutor_id = %s", 1, userid, content["swipedId"] )
        else:
            db.engine.execute("UPDATE matches SET tutor_swipe = %s WHERE tutor_id = %s AND student_id = %s", 1, userid, content["swipedId"] )

    return jsonify({'success' : 1})




@app.route("/leftSwipe", methods=['GET', 'POST'])
def leftSwipe():
    content = request.json


    matchCheck = db.engine.execute("SELECT COUNT(id) FROM matches WHERE student_id = %s and tutor_id = %s", userid,content["swipedId"])
    matchCheck2 = db.engine.execute("SELECT COUNT(id) FROM matches WHERE tutor_id = %s and student_id = %s", userid,content["swipedId"])


    if matchCheck == 0 and matchCheck2 == 0:
        print("no entry in table")
        if accountType == "student":
            newEnt = matches(student_id = userid, tutor_id = content["swipedId"],student_swipe = 2, tutor_swipe = 0)
            db.session.add(newEnt)
    	    db.session.commit()
        
        else:
            newEnt = matches(student_id = content["swipedId"], tutor_id = userid, student_swipe = 0, tutor_swipe = 2)
            db.session.add(newEnt)
    	    db.session.commit()
    else:
        if accountType == "student":
            db.engine.execute("UPDATE matches SET student_swipe = %s WHERE student_id = %s AND tutor_id = %s", 2, userid, content["swipedId"] )
        else:
            db.engine.execute("UPDATE matches SET tutor_swipe = %s WHERE tutor_id = %s AND student_id = %s", 2, userid, content["swipedId"] )
    
    return jsonify({'success' : 1})


@app.route("/matches", methods=['GET', 'POST'])
def matches():
    content = request.json


    matchData = []


    if accountType == "student"
        mm = matches.query.filter_by(student_id = userid, tutor_swipe = 1, student_swipe = 1)

        for x in mm:
            user = users.query.filter_by(id = x.tutor_id).first
            dd = {'username' : user.username, 'userid' : user.id, 'email':user.email, 'fullName':user.fullName}
            matchData.append(dd)

    else:
        mm = matches.query.filter_by(tutor_id = userid, tutor_swipe = 1, student_swipe = 1)
        for x in mm:
            user = users.query.filter_by(id = x.student_id).first
            dd = {'username' : user.username, 'userid' : user.id, 'email':user.email, 'fullName':user.fullName}
            matchData.append(dd)


    return jsonify({'matches' : matchData})
    



# SQL Queries
# 
# For checking whether there a student has any available matches: 
# SELECT * FROM `casinoroyale`.`matches` WHERE student_id=(userid) AND student_swipe=1 AND tutor_swipe=1;
#
#
#For checking whether a match exists (on swipe request)
#
#SELECT * FROM `casinoroyale`.`matches` WHERE student_id=(sid) AND tutor_id=tid
#
#For inserting a match into the Matches table (if a match did not exist)
#
# 
# INSERT INTO `casinoroyale`.`matches` (id,student_id,tutor_id,student_swipe,tutor_swipe)
# VALUES (Match ID,Student ID, Tutor ID,1,0);
# (swap the 1 and 0 if the tutor is the one who swiped right)
#
#
# For updating an existing match into the matches table (if the match already does exist)
#
# Assuming student swipe, if tutor swipe change the SET statement to tutor_swipe
# UPDATE `casinoroyale`.`matches` SET student_swipe =1 WHERE student_id=sid AND tutor_id=tid;
#
#Prospective command flow (pseudo-code)
#
#On check for matches:
#
# if(check_matches.exists()){
#   send list of tutor IDs ordered first-last.
#   make an arraylist to return with all matching tutor entries 
 #  }
# else{
#       do nothing
#    }
#
#
#
# On swiping:
# check type of originating account (student or tutor)
# Assign student_id and tutor_id (sid and tid)
# if(match-exists){
#       run update;
#   }
# else{
#       run create_match;  
# }
#