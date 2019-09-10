import os
import random
import smtplib
from flask import Flask,render_template,url_for,request,flash,session,logging,Response,redirect,jsonify,json
from flask_mysqldb import MySQL
from wtforms import Form,fields,StringField,TextAreaField, PasswordField,validators,FileField
from passlib.hash import sha256_crypt
from functools import wraps
from itsdangerous import URLSafeTimedSerializer, SignatureExpired
from flask_mail import Mail, Message
# from flask.ext.wtf.recaptcha import RecaptchaField
app = Flask('__name__')

app.config['MYSQL_HOST']='localhost'
app.config['MYSQL_USER']='root'
app.config['MYSQL_PASSWORD']=''
app.config['MYSQL_DB'] = 'online'
app.config['MYSQL_CURSORCLASS']='DictCursor'
app.config['MAIL_SERVER']='smtp.gmail.com'
app.config['MAIL_PORT']=465
app.config['MAIL_USE_SSL']=True
app.config['MAIL_USERNAME']='youremail'
app.config['MAIL_PASSWORD']='yourpassword'
app.config['MAIL_MAX_EMAILS']=10
# app.config['RECHAPCHA_PUBLIC_KEY']='6LeD3z4UAAAAAL7lXz0ZVT2Jhqpl7mnKznQTpGBL'
# app.config['RECHAPCHA_PRIVATE_KEY']='6LeD3z4UAAAAAGr7t2pl7Q0G1r1ivHySDY2_wqxh'

mysql = MySQL(app)
mail=Mail(app)


s = URLSafeTimedSerializer('secret123')

def is_logged_in(f):
	@wraps(f)
	def wrap(*args, **kwargs):
		if 'logged_in' in session:
			return f(*args, **kwargs)
		else:
			flash('Unauthorized, Please login', 'danger')
			return redirect(url_for('login'))
	return wrap


@app.route('/')
def index():
	return render_template('index.html')

@app.route('/register', methods=['GET','POST'])
def register():
	if request.method == 'POST':
		first_name = request.form['first_name']
		second = request.form['second_name']
		father = request.form['father_name']
		dof = request.form['dof'] 	
		phone = request.form['phone']
		city = request.form['city']
		pin = request.form['pin']
		district  = request.form['district']
		state = request.form['state']
		martial = request.form['martialstatus']
		pan = request.form['panno']
		aadhar = request.form['aadhar']
		accstatus = 'NOT ACCEPTED'
		cur = mysql.connection.cursor()
		cur.execute("INSERT INTO registerdmem(first_name,last_name,father_name,dof,phone,city,pin,district,state,martialstatus,pan,aadhar,accstatus) VALUES ( %s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s ) ",[first_name,second,father,dof,phone,city,pin,district,state,martial,pan,aadhar,accstatus])
		mysql.connection.commit()
		cur.close()
		return redirect(url_for('login'))
	return render_template("register.html")

@app.route('/login',methods=['GET','POST'])
def login():
	if request.method == 'POST':
		loginid = request.form['login']
		accpassword = request.form['password']
		cur = mysql.connection.cursor()
		result = cur.execute("SELECT * FROM custmdetails WHERE loginid=%s",[loginid])
		if result > 0:
			data = cur.fetchone()
			password = data['password']
			if accpassword==password:
				session['logged_in']=True
				session['loginid']=loginid 
				session['custmid']=data['custmid']
				session['ifsc']=data['ifsc']
				session['status']=data['status']
				# session['accopendate']=data['accopendate']
				# session['lastlogin'] = data['lastlogin']		
				flash('you are now logged in')
				return redirect(url_for('accountalerts'))
			else:
				error = 'Invald password'
				return render_template('login.html',error=error)
			cur.close()
		else:
			error = 'Loginid not found'
			return render_template('login.html', error=error)
	return render_template('login.html')

@app.route('/accountalerts', methods=['GET','POST'])
@is_logged_in
def accountalerts():
	custmid = session['custmid']
	cur = mysql.connection.cursor()
	result = cur.execute("SELECT * FROM custmdetails WHERE custmid=%s",[custmid])
	get = cur.fetchall()
	if result > 0:
		return render_template('accountalerts.html', get=get)
	else:
		msg ="not fount"
		return render_template('accountalerts.html', msg=msg)
	cur.close()
	return render_template('accountalerts.html')

@app.route('/makepayment',methods=['GET','POST'])
@is_logged_in
def makepayment():
	if request.method == 'POST':
		custmid= session['custmid']
		ifsc=session['ifsc']
		acc_holder = request.form['acc_holder']
		acc_money = request.form['acc_money']
		acc_number = request.form['acc_number']
		acc_ifsc = request.form['acc_ifsc']
		# acc_ifsc = request.form['acc_ifsc']
		cur = mysql.connection.cursor()
		
			#USER LOGGED IN ACCOUNT => MONEY SENDER
		result1 = cur.execute('SELECT * FROM accountdetails WHERE custmid =%s',[custmid])
		data = cur.fetchone()
		acc=data['accountno']
			#USER NOT LOGGED IN => MONEY RECEIVER 
		result2 = cur.execute('SELECT * FROM accountdetails WHERE accountno =%s',[acc_number])
		fetch2 = cur.fetchone()
			
			# SENDER CURRENT BALANCE1111
		p1amount = data['accbalance']
			#RECEIVER CURRENT BALANCE
		p2send = fetch2['accbalance']
			
			#SENDER BALANCE UPDATEDED AFTER MONEY TANSFER 
		remaining = int(p1amount) - int(acc_money)
		cur.execute("UPDATE accountdetails SET accbalance=%s WHERE custmid=%s",(remaining,custmid))
		status = 'SUCCESS'
		cur.execute("INSERT INTO transactions(accountno,purpose,widthdraw,status)VALUES(%s,%s,%s,%s)",(acc_number,'Bill',acc_money,status))
			#RECEIVER BALACE UPDATEDED AFTER MONEY TRANSFER
		total = int(p2send) + int(acc_money)
		cur.execute("UPDATE accountdetails SET accbalance=%s WHERE accountno=%s",(total,acc_number))
		status = 'SUCCESS'
		cur.execute("INSERT transactions (accountno,purpose,credited,status)VALUES(%s,%s,%s,%s)",(acc_number,'bill',acc_money,status))
		mysql.connection.commit()
		cur.close()
			#i= int(acc_number) - int(acc_money)
		return redirect(url_for('makepayment'))

	return render_template('makepayment.html')
@app.route('/register_member/<string:id>',methods=['GET','POST'])

	
@app.route('/logout')
def logout():
	session.clear()
	flash('you are now logged out','success')
	return redirect(url_for('login'))

@app.route('/transferfunds')
def transferfunds():
	return render_template('transferfund.html')
	
@app.route('/personal_info',methods=['GET','POST'])
def personal_info():
	custmid = session['custmid']
	cur = mysql.connection.cursor()
	cur.execute('SELECT * FROM accountdetails WHERE custmid=%s',[custmid])
	result = cur.fetchone()
	aadhar = result['aadharr']
	aadharr = str(aadhar)
	cur.execute('SELECT * FROM registerdmem WHERE aadhar=%s',[aadharr])
	result1 = cur.fetchall()
	if request.method == 'POST':
		password = request.form['password']
		cpassword = request.form['cpassword']
		if password == cpassword:
			cur.execute('UPDATE custmdetails SET password =%s WHERE custmid=%s',(password,custmid))
			mysql.connection.commit()
			cur.close()
			return redirect(url_for('personal_info'))
		return 'fail'
	cur.close()
	return render_template('personal_info.html',result=result,result1=result1)

@app.route('/example2')
def example2():
	cur = mysql.connection.cursor()
	cur.execute('SELECT * FROM transactions')
	result = cur.fetchall()
	return render_template('example2.html', result=result)


@app.route('/pendingpayments')
def pending():
	return render_template('pendingpayments.html')
@app.route('/mailinbox')
def inbox():
	return render_template('mails.html')
@app.route('/viewtransactionlist')
def paidlist():
	return render_template('viewtransactionlist.html')
@app.route('/confirm')
def confirm():
	return render_template('confirmpayment.html')


# ALL ADMIN MODULES COMPLETED

@app.route('/admin_login',methods=['GET','POST'])
def admin_login():
	if request.method=='POST':
		loginid = request.form['loginid']
		accpassword = request.form['password']
		cur = mysql.connection.cursor()
		result = cur.execute("SELECT * FROM employeelogin WHERE loginid=%s",[loginid])
		if result > 0:
			data = cur.fetchone()
			password = data['password']
			if accpassword == password:
				session['logged_in']=True
				session['loginid']=loginid 
				session['empid']=data['empid']
				session['ifsc']=data['ifsc']		
				flash('you are now logged in')
				return redirect(url_for('dashboard'))
			else:
				error = 'Invald password'
				return render_template('adminlogin.html',error=error)
			cur.close()
		else:
			error = 'Loginid not found'
			return render_template('adminlogin.html', error=error)
		return render_template('adminlogin.html')
	return render_template('adminlogin.html')

@app.route('/dashboard')
def dashboard():
	accstatus = 'NOT ACCEPTED'
	cur = mysql.connection.cursor()
	result = cur.execute('SELECT count(*)+1 FROM accountdetails')
	c=cur.fetchone()
	result1 = cur.execute('SELECT SUM(accbalance) FROM accountdetails')
	acc = cur.fetchone()
	result2 = cur.execute('SELECT * FROM registerdmem WHERE accstatus=%s',[accstatus])
	gets = cur.fetchall()
	if result >0:
		return render_template('admindashboard.html',gets=gets, acc=acc,result=c)
	else:
		msg = 'No Request'
		return render_template('admindashboard.html',msg=msg)
	cur.close()
	return render_template('admindashboard.html',result=c)

@app.route('/see')
def see():
	cur = mysql.connection.cursor()
	result = cur.execute('SELECT count(*)+1 FROM accountdetails')
	c=cur.fetchone()
	result1 = cur.execute('SELECT SUM(accbalance) FROM accountdetails')
	acc = cur.fetchone()
	ac =  json.dumps(str(acc))
	re = json.loads(ac)	
	return re['SUM(accbalance)']

@app.route('/admindashboard/register_member/<string:id>', methods=['GET','POST'])
def rgister_id(id):
	cur = mysql.connection.cursor()
	details = cur.execute('SELECT * FROM registerdmem WHERE id=%s',[id])
	data = cur.fetchall()
	if request.method == 'POST':
		if request.form['accepted'] == 'accept':
			accstatus = request.form['accepted']
			custmid = random.randint(11111,99999)
			loginid = random.randint(111111,999999)
			accountno = random.randint(1111111111,9999999999)
			password = request.form['dof']
			aadhar = request.form['aadhar']
			nemail = request.form['email']
			type1 = 'saving'
			ifsc = 'SRI0000246'
			status = 'active'
			token = s.dumps(nemail,salt='sendaccde')
			cur.execute('UPDATE registerdmem SET accstatus=%s WHERE id=%s',(accstatus,id))
			cur.execute('INSERT INTO custmdetails(custmid,loginid,password,status,aadhar,ifsc) VALUES(%s,%s,%s,%s,%s,%s)',(custmid,loginid,password,status,aadhar,ifsc))
			cur.execute('INSERT INTO accountdetails(accountno,custmid,accountstatus,type,ifsc,aadharr) VALUES(%s,%s,%s,%s,%s,%s)',(accountno,custmid,status,type1,ifsc,aadhar))
			message = Message('register',
				sender='saikkdyashwanth@gmail.com',
				recipients=[nemail])
			link = url_for('sendaccde',token=token,_external=True)
			message.body = 'you link is {}'.format(link)
			mail.send(message)
			mysql.connection.commit()
			cur.close()
			return render_template('sendaccdetail.html',aadhar=aadhar,nemail=nemail)
		return 'fail1'
	return render_template('request_person.html', data=data)

@app.route('/sendaccde/<token>',methods=['GET','POST'])
def sendaccde(token):
	if request.method == 'POST':
		aadhar = request.form['aadhar']
		dof = request.form['dof']
		phone = request.form['phone']
		cur = mysql.connection.cursor()
		count = cur.execute('SELECT * FROM registerdmem WHERE aadhar=%s AND dof=%s',(aadhar,dof))
		if count >0:
			cur.execute('SELECT * FROM custmdetails WHERE aadhar=%s',[aadhar])
			data = cur.fetchall()
			# custmid = data['custmid']
			i = data['value']
			if i == 0:
				cur.execute('SELECT * FROM accountdetails WHERE custmid=%s',[aadhar])
				fatched = cur.fetchall()
				value=1
				cur.execute('UPDATE custmdetails SET value=%s WHERE custmid=%s',(value,custmid))
				return render_template('sendaccdetail.html',data=data,fatched=fatched)
			return render_template('details.html')
		return render_template('detail.html')
	return render_template('details.html',)


@app.route('/allbranches')
def branch():
	cur = mysql.connection.cursor()
	cur.execute('SELECT * FROM branches')
	branches = cur.fetchall()
	return render_template('bankbranches.html',branches=branches)

@app.route('/allbranches/<string:ifsc>')
def all_view(ifsc):
	cur = mysql.connection.cursor()
	cur.execute('SELECT * FROM branches WHERE ifsc = %s',[ifsc])
	get = cur.fetchall()
	return render_template('viewbranch.html',get = get)

@app.route('/admintable')
def adminprofile():
	cur = mysql.connection.cursor()
	data = cur.execute('SELECT * FROM accountdetails')
	results = cur.fetchall()
	if data >0:
		return render_template('admintable.html',results=results)
	else:
		return render_template('admintable.html')
	cur.close()
	return render_template('admintable.html')

@app.route('/admintable/user/<string:custmid>', methods=['GET','POST'])
def detail(custmid):
	cur = mysql.connection.cursor()
	cur.execute('SELECT * FROM accountdetails WHERE custmid=%s',[custmid])
	fetch = cur.fetchone()
	acc = fetch['accountno']
	aadhar = fetch['aadharr']
	balance = fetch['accbalance']
	sannasi =cur.execute('SELECT * FROM registerdmem WHERE aadhar = %s', [aadhar])
	fetch1 = cur.fetchall()
	if request.method == 'POST':
		first_name = request.form['first_name']
		second = request.form['last_name']
		father = request.form['father_name']
		dof= request.form['dof']
		phone = request.form['phone']
		city = request.form['city']
		pin = request.form['pin']
		district = request.form['district']
		state = request.form['state']
		cur.execute('UPDATE registerdmem SET first_name=%s,last_name=%s,father_name=%s,dof=%s,phone=%s,city=%s,pin=%s,district=%s,state=%s WHERE aadhar=%s',(first_name,second,father,dof,phone,city,pin,district,state,aadhar))
		mysql.connection.commit()
		cur.close()
		return redirect(url_for('adminprofile'))
	return render_template('adminuser.html',fetch1=fetch1 , aadhar=acc, balance=balance)

@app.route('/allemployees')
def allemployees():
	cur = mysql.connection.cursor()
	cur.execute('SELECT * FROM employeedetails')
	result = cur.fetchall()
	return render_template('viewallemployess.html', result = result)


#MODULES COMPLETED UPTO HERE

@app.route('/example')
def example():
	return render_template('example.html')

# @app.route('/example3')
# def example3():
# 	return render_template('example3.html')
@app.route('/deposite/<string:empid>')
def one():
	return render_template('adminlogin.html')




if __name__ == '__main__':
	app.secret_key = 'secret123'
	app.run(host="127.0.0.1",port="3000",debug=True)
