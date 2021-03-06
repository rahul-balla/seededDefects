import os
from flask import Flask, jsonify, json, send_file
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import Index, func
from flask_bootstrap import Bootstrap
from flask_bcrypt import Bcrypt
from flask_mail import Mail
import time
from flask_login import LoginManager, UserMixin, login_user, login_required, logout_user, current_user
from datetime import datetime
from itsdangerous import TimedJSONWebSignatureSerializer as Serializer
from PIL import Image
from io import BytesIO
import zipfile

import json
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
    settings = db.Column(db.String(1000))
    onCampus = db.Column(db.Integer)
    offCampus = db.Column(db.Integer)
    fs = db.Column(db.Integer)
    js = db.Column(db.Integer)
    cheap = db.Column(db.Integer)
    medium = db.Column(db.Integer)
    expensive = db.Column(db.Integer)
    com = db.Column(db.Integer)
    cs = db.Column(db.Integer)
    bio = db.Column(db.Integer)
    econ = db.Column(db.Integer)
    chem = db.Column(db.Integer)
    english = db.Column(db.Integer)
    physics = db.Column(db.Integer)
    math = db.Column(db.Integer)
    description = db.Column(db.String(500))
    price = db.Column(db.Integer)
    schedule = db.Column(db.String(500))
    numRatings = db.Column(db.Integer)
    totalRating = db.Column(db.Integer)

    #pictureName = db.Column(db.String(50))
    picture = db.Column(db.VARBINARY(1000000))


    def __repr__(self):
        return "users('{self.username}', {self.email}', {self.password}', {self.fullName}')"


class matches(UserMixin, db.Model):
    id = db.Column(db.Integer, primary_key=True, nullable = False)
    student_id = db.Column(db.Integer)
    tutor_id = db.Column(db.Integer)
    student_swipe = db.Column(db.Integer)
    tutor_swipe = db.Column(db.Integer)


    def __repr__(self):
        return "matches('{self.student_id}', {self.tutor_id}', {self.student_swipe}', {self.tutor_swipe}')"

class ratings(UserMixin,db.Model):
    id = db.Column(db.Integer, primary_key=True, nullable = False)
    rater_id = db.Column(db.Integer)
    rated_id = db.Column(db.Integer)

################################################ ROUTES ########################################################
@app.route("/createAccount", methods=['GET', 'POST'])
def createAccount():
	content = request.json
        
        usernameCheck = db.engine.execute("SELECT COUNT(id) FROM users WHERE username = %s", content["username"]).scalar()
        emailCheck = db.engine.execute("SELECT COUNT(id) FROM users WHERE email = %s", content["email"]).scalar()

        if content["username"] == 'test':
            return jsonify({'success' : 5})


        if usernameCheck > 0 :
            return jsonify({'success' : 2})
        
        if emailCheck > 0 :
            return jsonify({'success' : 3})

        if strn.find("@") == -1 :
            return jsonify({'success' : 4})

        if content["account_type"] == "student":
            user = users(username = content["username"], password = content["password"], email = content["email"], account_type = content["account_type"], fullName = content["name"], numRatings = 0, totalRating = 0,)
            db.session.add(user)
    	    db.session.commit()
        else :
            user = users(username = content["username"], password = content["password"], email = content["email"], account_type = content["account_type"], fullName = content["name"], numRatings = 0, totalRating = 0, description = content["description"], price = content["charge"])
    	    db.session.add(user)
    	    db.session.commit()

    	return jsonify({'success' : 1})

@app.route("/login", methods=['GET', 'POST'])
def login():
    content = request.json
        
    emailCheck = db.engine.execute("SELECT COUNT(id) FROM users WHERE email = %s", content["email"]).scalar()

    if emailCheck == 0 : 
        return jsonify({'success' : 3})

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
    
    userRat = 0

    if user.numRatings == 0 : 
        userRat = 0
    else :
        userRat = (float(user.totalRating)/float(user.numRatings))
    
    return jsonify({'username' : user.username, 'email' : user.email, 'account_type' : user.account_type, 'fullName' : user.fullName, 'schedule' : user.schedule, 'rating' : round(userRat,1), 'description':user.description, 'charge': user.price, 'userid' : userid })


@app.route("/settings", methods=['GET', 'POST'])
def settings():
    content = request.json
    print(content)


    db.engine.execute("UPDATE users SET settings = %s, onCampus = %s, offCampus = %s, fs = %s, js = %s, cheap = %s, medium = %s, expensive = %s, com = %s, cs = %s, bio = %s, econ = %s, chem = %s, english = %s, physics = %s, math = %s WHERE id = %s", str(content), content["oncSwitchOn"], content["offcSwitchOn"],content["fsSwitchOn"], content["jsSwitchOn"], content["cheapSwitchOn"], content["medSwitchOn"], content["expensiveSwitchOn"], content["comSwitchOn"], content["csSwitchOn"], content["bioSwitchOn"], content["econSwitchOn"],content["chemSwitchOn"], content["englishSwitchOn"], content["physicsSwitchOn"], content["mathSwitchOn"], userid)

    return jsonify({'success' : 1})
    
@app.route("/picFeed", methods=['GET', 'POST'])
def picFeed():
    
    memory_file = BytesIO()
    
    if accountType == "student" :
        feed = users.query.filter_by(account_type = "tutor")
        
        with zipfile.ZipFile(memory_file, 'w') as zf:
            for x in feed:
				matchCheck = db.engine.execute("SELECT COUNT(id) FROM matches WHERE student_id = %s and tutor_id = %s", userid,x.id).scalar()
                    
				if matchCheck == 0 and x.picture is not None:
					#write blob into file
					eachFileName = str(x.id) + ".jpg"
					eachFile = open(eachFileName,'wb')
					eachFile.write(x.picture)
					#eachFile.write(x.picture.decode('base64'))
					eachFile.close()

					#putting files into zip
					f=open(eachFileName, "r")
					# img = Image.open(BytesIO(f.read()))
					# img.show()
					print("one file name: ", eachFileName)
					data = zipfile.ZipInfo(eachFileName)
					#data.date_time = time.localtime(time.time())[:6]
					data.compress_type = zipfile.ZIP_DEFLATED
					zf.writestr(data, f.read())
					f.close()

    if accountType == "tutor" :
        feed = users.query.filter_by(account_type = "student")
        
        with zipfile.ZipFile(memory_file, 'w') as zf:
            for x in feed:
                matchCheck = db.engine.execute("SELECT COUNT(id) FROM matches WHERE student_id = %s and tutor_id = %s", userid,x.id).scalar()
                    
                if matchCheck == 0 and x.picture is not None:
                    #write blob into file
                    eachFileName = str(x.id) + ".jpg"
                    eachFile = open(eachFileName,'wb')
                    eachFile.write(x.picture)
                    #eachFile.write(x.picture.decode('base64'))
                    eachFile.close()

                    #putting files into zip
                    f=open(eachFileName, "r")
                    # img = Image.open(BytesIO(f.read()))
                    # img.show()
                    print("one file name: ", eachFileName)
                    data = zipfile.ZipInfo(eachFileName)
                    #data.date_time = time.localtime(time.time())[:6]
                    data.compress_type = zipfile.ZIP_DEFLATED
                    zf.writestr(data, f.read())
                    f.close()




    
    #print("THIS THE DICTIONARY length : ", len(fileDict))
    memory_file.seek(0)
    return send_file(memory_file, attachment_filename='pictures.zip', as_attachment=True)

@app.route("/feed", methods=['GET', 'POST'])
def feed():
    userDict = []

    print("hellooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo")

    if accountType == "student" :
        print("student")

        currUser = users.query.filter_by(id = userid).first()

        feed = users.query.filter_by(account_type = "tutor")


        userRat2 = 0

        if currUser.numRatings == 0 : 
            userRat2 = 0
        else :
            userRat2 = (float(currUser.totalRating)/float(currUser.numRatings))


        mm = {'username' : currUser.username, 'userid' : currUser.id, 'email':currUser.email, 'fullName':currUser.fullName, 'schedule' : currUser.schedule, 'rating' : round(userRat2,1), 'description':currUser.description, 'charge': currUser.price,'numRatings': currUser.numRatings }

        userDict.append(mm) 


        for x in feed:
            matchCheck = db.engine.execute("SELECT COUNT(id) FROM matches WHERE student_id = %s and tutor_id = %s and (student_swipe = 1 or student_swipe = 2)", userid,x.id).scalar()
            #             matchCheck = matches.query.filter_by(student_id = userid, tutor_id = x.id).count()

            print("match check = ", matchCheck)

            if matchCheck == 0:
                print("feed = ihbuhbuhbuibub")

                if currUser.settings == None:
                    userRat = 0

                    if x.numRatings == 0 : 
                        userRat = 0
                    else :
                        userRat = (float(x.totalRating)/float(x.numRatings))

                    dd = {'username' : x.username, 'userid' : x.id, 'email':x.email, 'fullName':x.fullName, 'schedule' : x.schedule, 'rating' : round(userRat,1), 'description':x.description, 'charge': x.price, 'numRatings': x.numRatings}
                    userDict.append(dd)
                    print("In the first if statement\n")   
                elif ((currUser.fs == 1 and (x.fs == 0 or x.fs == None)) or (currUser.js == 1 and (x.js == 0 or x.js == None)) or (currUser.cheap == 1 and (x.cheap == 0 or x.cheap == None)) or (currUser.medium == 1 and (x.medium == 0 or x.medium == None)) or (currUser.expensive == 1 and (x.expensive == 0 or x.expensive == None)) or (currUser.com == 1 and (x.com == 0 or x.com == None)) or (currUser.cs == 1 and (x.cs == 0 or x.cs == None)) or (currUser.bio == 1 and (x.bio == 0 or x.bio == None))  or (currUser.econ == 1 and (x.econ == 0 or x.econ == None)) or (currUser.chem == 1 and (x.chem == 0 or x.chem == None)) or (currUser.english == 1 and (x.english == 0 or x.english == None)) or (currUser.physics == 1 and (x.physics == 0 or x.physics == None))) :
                    print("In the second if statement\n")
                else:
                    print("in the else statement")

                    userRat = 0

                    if x.numRatings == 0 : 
                        userRat = 0
                    else :
                        userRat = (float(x.totalRating)/float(x.numRatings))

                    dd = {'username' : x.username, 'userid' : x.id, 'email':x.email, 'fullName':x.fullName, 'schedule' : x.schedule, 'rating' : round(userRat,1), 'description':x.description, 'charge': x.price, 'numRatings': x.numRatings }
                    userDict.append(dd)

    else:
        currUser = users.query.filter_by(id = userid).first()

        print("tutor")

        feed = users.query.filter_by(account_type = "student")
        
        for x in feed:
            matchCheck = db.engine.execute("SELECT COUNT(id) FROM matches WHERE student_id = %s and tutor_id = %s and (tutor_swipe = 1 or tutor_swipe = 2)", x.id, userid).scalar()
            if matchCheck == 0:
                if currUser.settings == None:
                    userRat = 0

                    if x.numRatings == 0 : 
                        userRat = 0
                    else :
                        userRat = (float(x.totalRating)/float(x.numRatings))
    
                    dd = {'username' : x.username, 'userid' : x.id, 'email':x.email, 'fullName':x.fullName, 'schedule' : x.schedule, 'rating' : round(userRat,1), 'description':x.description, 'charge': x.price, 'numRatings': x.numRatings }
                    userDict.append(dd)
                
                elif ((currUser.fs == 1 and (x.fs == 0 or x.fs == None)) or (currUser.js == 1 and (x.js == 0 or x.js == None)) or (currUser.cheap == 1 and (x.cheap == 0 or x.cheap == None)) or (currUser.medium == 1 and (x.medium == 0 or x.medium == None)) or (currUser.expensive == 1 and (x.expensive == 0 or x.expensive == None)) or (currUser.com == 1 and (x.com == 0 or x.com == None)) or (currUser.cs == 1 and (x.cs == 0 or x.cs == None)) or (currUser.bio == 1 and (x.bio == 0 or x.bio == None))  or (currUser.econ == 1 and (x.econ == 0 or x.econ == None)) or (currUser.chem == 1 and (x.chem == 0 or x.chem == None)) or (currUser.english == 1 and (x.english == 0 or x.english == None)) or (currUser.physics == 1 and (x.physics == 0 or x.physics == None))) :
                    print("In the if statement\n")
                else:

                    userRat = 0

                    if x.numRatings == 0 : 
                        userRat = 0
                    else :
                        userRat = (float(x.totalRating)/float(x.numRatings))
    
                    dd = {'username' : x.username, 'userid' : x.id, 'email':x.email, 'fullName':x.fullName, 'schedule' : x.schedule, 'rating' : round(userRat,1), 'description':x.description, 'charge': x.price, 'numRatings': x.numRatings }
                    userDict.append(dd)

    print("userDict : ",userDict)

    return jsonify({'feed': userDict})

@app.route("/rightSwipe", methods=['GET', 'POST'])
def rightSwipe():
    content = request.json

    print("swipedId = ", content["swipedId"])


    matchCheck = db.engine.execute("SELECT COUNT(id) FROM matches WHERE student_id = %s and tutor_id = %s", userid,content["swipedId"]).scalar()
    matchCheck2 = db.engine.execute("SELECT COUNT(id) FROM matches WHERE tutor_id = %s and student_id = %s", userid,content["swipedId"]).scalar()


    if matchCheck == 0 and matchCheck2 == 0:
        if accountType == "student":

        	db.engine.execute("INSERT INTO matches (student_id, tutor_id, student_swipe, tutor_swipe)VALUES (%s, %s,%s,%s)", userid, content["swipedId"], 1,0)
        else:

    	    db.engine.execute("INSERT INTO matches (student_id, tutor_id, student_swipe, tutor_swipe)VALUES (%s, %s,%s,%s)", content["swipedId"], userid, 0,1)

    else:
        if accountType == "student":
            db.engine.execute("UPDATE matches SET student_swipe = %s WHERE student_id = %s AND tutor_id = %s", 1, userid, content["swipedId"] )
        else:
            db.engine.execute("UPDATE matches SET tutor_swipe = %s WHERE tutor_id = %s AND student_id = %s", 1, userid, content["swipedId"] )


    if accountType == "student" : 
        justMatched = matches.query.filter_by(student_id = userid, tutor_id = content["swipedId"]).first()
        if(justMatched.tutor_swipe == 1 and justMatched.student_swipe == 1):
                return jsonify({'success' : 5})
    else:
        justMatched = matches.query.filter_by(student_id = content["swipedId"], tutor_id = userid).first()
        if(justMatched.tutor_swipe == 1 and justMatched.student_swipe == 1):
                return jsonify({'success' : 5})

    return jsonify({'success' : 1})




@app.route("/leftSwipe", methods=['GET', 'POST'])
def leftSwipe():
    content = request.json

    print("swipedId = ", content["swipedId"])


    matchCheck = db.engine.execute("SELECT COUNT(id) FROM matches WHERE student_id = %s and tutor_id = %s", userid,content["swipedId"]).scalar()
    matchCheck2 = db.engine.execute("SELECT COUNT(id) FROM matches WHERE tutor_id = %s and student_id = %s", userid,content["swipedId"]).scalar()


    if matchCheck == 0 and matchCheck2 == 0:
        if accountType == "student":
            # newEnt = matches(student_id = userid, tutor_id = content["swipedId"],student_swipe = 1, tutor_swipe = 0)
            # db.session.add(newEnt)
    	    # db.session.commit()
       
        	db.engine.execute("INSERT INTO matches (student_id, tutor_id, student_swipe, tutor_swipe)VALUES (%s, %s,%s,%s)", userid, content["swipedId"], 2,0)
        else:
         #    newEnt = matches(student_id = content["swipedId"], tutor_id = userid, student_swipe = 0, tutor_swipe = 1)
         #    db.session.add(newEnt)
    	    # db.session.commit()
    	    db.engine.execute("INSERT INTO matches (student_id, tutor_id, student_swipe, tutor_swipe)VALUES (%s, %s,%s,%s)", content["swipedId"], userid, 0,2)

    else:
        if accountType == "student":
            db.engine.execute("UPDATE matches SET student_swipe = %s WHERE student_id = %s AND tutor_id = %s", 2, userid, content["swipedId"] )
        else:
            db.engine.execute("UPDATE matches SET tutor_swipe = %s WHERE tutor_id = %s AND student_id = %s", 2, userid, content["swipedId"] )

    return jsonify({'success' : 1})


@app.route("/schedule", methods=['GET', 'POST'])
def schedule():
    content = request.json

    db.engine.execute("UPDATE users SET schedule = %s WHERE id = %s", content['schedule'], userid)

    return jsonify({'success' : 1})


@app.route("/matchesPage", methods=['GET', 'POST'])
def matchesPage():
    matchesDict = []

    if accountType == "student" : 
        print("hello : ", userid)
        matchess = matches.query.filter_by(student_id = userid, student_swipe = 1, tutor_swipe = 1)
        if matchess != None:
            for x in matchess:
                matchInfo = users.query.filter_by(id = x.tutor_id).first()
                print("match info = ", x.tutor_id)


                userRat = 0

                if matchInfo.numRatings == 0 : 
                    userRat = 0
                else :
                    userRat = (float(matchInfo.totalRating)/float(matchInfo.numRatings))
    
                dd = {'username' : matchInfo.username, 'userid' : matchInfo.id, 'email':matchInfo.email, 'fullName':matchInfo.fullName, 'schedule' : matchInfo.schedule, 'rating' : round(userRat,1), 'description':matchInfo.description, 'charge': matchInfo.price,'numRatings': matchInfo.numRatings }
                matchesDict.append(dd)
    else:
        matchess = matches.query.filter_by(tutor_id = userid, student_swipe = 1, tutor_swipe = 1)
        if matchess != None:
            for x in matchess:
                matchInfo = users.query.filter_by(id = x.student_id).first()

                userRat = 0

                if matchInfo.numRatings == 0 : 
                    userRat = 0
                else :
                    userRat = (float(matchInfo.totalRating)/float(matchInfo.numRatings))
    
                dd = {'username' : matchInfo.username, 'userid' : matchInfo.id, 'email':matchInfo.email, 'fullName':matchInfo.fullName, 'schedule' : matchInfo.schedule, 'rating' : round(userRat,1), 'description':matchInfo.description, 'charge': matchInfo.price, 'numRatings': matchInfo.numRatings }
                matchesDict.append(dd)

    print("matchesDics = ", matchesDict)

    return jsonify({'matches': matchesDict})


@app.route("/rateUser", methods=['GET', 'POST'])
def rateUser():
    content = request.json

    rat = ratings(rater_id = userid, rated_id = content["ratedId"])
    db.session.add(rat)
    db.session.commit()
    
    
    rated = users.query.filter_by(id = content["ratedId"]).first()

    num = 0
    rating = 0

    if rated.numRatings is None :
        num = 1
    else :
        num = rated.numRatings + 1

    if rated.totalRating is None :
        rating = content["rating"]
    else :
        rating = rated.totalRating + content["rating"]

    db.engine.execute("UPDATE users SET numRatings = %s, totalRating = %s WHERE id = %s", num, rating, content["ratedId"])

    return jsonify({'rating' : 1})

@app.route("/updateProfile", methods=['GET', 'POST'])
def updateProfile():
    file = request.files['file']
    content = request.json

	#print("hmmm:", request.files['file'])
        
    if file:
        #img = Image.open(file)
        print("file name:", file.filename)
    #img.show()
    
    db.engine.execute("UPDATE users SET picture = %s where id = %s", file.read(), userid )
    
    print("userid: ", userid)
    print("database call worked!")
    pic = users.query.filter_by(id = userid).first()
    
    img = Image.open(BytesIO(pic.picture))
    print("PLEASE WORK D:")
    print("image: ", img)
        
    return jsonify({'updateProfile Success' : ':D'})

@app.route("/updateProfileInfo", methods=['GET', 'POST'])
def updateProfileInfo():
    content = request.json
    print("CONTENT:", content)

    db.engine.execute("UPDATE users SET username = %s, fullName = %s, description = %s, price = %s, email = %s WHERE id = %s", content["username"], content["name"], content["description"], content["charge"], content["email"], userid)

    
    return jsonify({'success' : 1})

@app.route("/retreiveProfilePic", methods=['GET', 'POST'])
def retreiveProfilePic():

    print("userid: ", userid)
    pic = users.query.filter_by(id = userid).first()
    
    img = Image.open(BytesIO(pic.picture))

    return send_file(BytesIO(pic.picture), attachment_filename='picture.zip', as_attachment=True)

@app.route("/retreiveMatchesPic", methods=['GET', 'POST'])
def retreiveMatchesPic():

    memory_file = BytesIO()

    #print("current account type", accountType)
    if accountType == "student" : 
        matchess = matches.query.filter_by(student_id = userid, student_swipe = 1, tutor_swipe = 1)
        if matchess != None:
            with zipfile.ZipFile(memory_file, 'w') as zf:
                for x in matchess:
                    matchInfo = users.query.filter_by(id = x.tutor_id).first()
                    print("match info = ", x.tutor_id)

                    #write blob into file
                    eachFileName = str(matchInfo.id) + ".jpg"
					
                    eachFile = open(eachFileName,'wb')
					
                    eachFile.write(matchInfo.picture)
					#eachFile.write(x.picture.decode('base64'))
					
                    eachFile.close()

					#putting files into zip
					
                    f=open(eachFileName, "r")
					# img = Image.open(BytesIO(f.read()))
					# img.show()
					
                    print("one file name: ", eachFileName)
					
                    data = zipfile.ZipInfo(eachFileName)
					#data.date_time = time.localtime(time.time())[:6]
					
                    data.compress_type = zipfile.ZIP_DEFLATED
					
                    zf.writestr(data, f.read())
					
                    f.close()
    # Tutor
    else:
        matchess = matches.query.filter_by(tutor_id = userid, student_swipe = 1, tutor_swipe = 1)
        if matchess != None:
            with zipfile.ZipFile(memory_file, 'w') as zf:
                for x in matchess:
                    matchInfo = users.query.filter_by(id = x.student_id).first()
                    print("match info = ", x.student_id)

                    #write blob into file
					
                    eachFileName = str(matchInfo.id) + ".jpg"
					
                    eachFile = open(eachFileName,'wb')
					
                    eachFile.write(matchInfo.picture)
					#eachFile.write(x.picture.decode('base64'))
					
                    eachFile.close()

					#putting files into zip
					
                    f=open(eachFileName, "r")
					# img = Image.open(BytesIO(f.read()))
					# img.show()
					
                    print("one file name: ", eachFileName)
					
                    data = zipfile.ZipInfo(eachFileName)
					
                    #data.date_time = time.localtime(time.time())[:6]
					
                    data.compress_type = zipfile.ZIP_DEFLATED
					
                    zf.writestr(data, f.read())
					
                    f.close()

    memory_file.seek(0)
    return send_file(memory_file, attachment_filename='pictures.zip', as_attachment=True)

