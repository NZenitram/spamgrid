#### SpamGrid

``
Through this app we will be able to send spam email through the SendGrid email platform using AWS instances and a Chef script that deploys and brings down servers as needed/banned.
``

### Problem

``
Spammers are running into new barriers when it comes to getting their email to a victims inbox. This app will allow a spammer to circumvent and utilize a reputable email sender's API and MTA to send email to their "customers".
``

### Clients

``
Our target client base includes scumbags and spammers from every walk of life.
``

I plan on using the SendGrid API, ~~Chef Open Source~~ Google OAuth, and a custom server automation script as a part of this project. The front end will be very basic with log-in capabilities and e-mail template upload. Iteration 2.0 may include a message board for spammer communications.

### Iteration One

Wireframe website design with a user dashboard and CRUD out basic user login with Google OAuth. Build out the ruby mailer and integrate with the SendGrid API to send email from my localhost. 

### Iteration Two

~~Learn and write Chef. Write a simple Chef Recipe to automatically deploy a Ruby environment to AWS EC2. Test tear down and create functionality of the script.~~ Write a Ruby script that will launch and tear down AWS EC2 instances with a ruby environment. The first instance will create the AMI with the application present and future instances will simply start and stop the servers that were created. AWS will issue a new IP each time a server is created, changing the host IP of the email sender. 

``
Determine if automated server deployment is a feasible. (This step will determine the next iteration)
``
