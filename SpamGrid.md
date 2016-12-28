#### SpamGrid

```
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

I plan on using the SendGrid API, Chef Open Source and Google OAuth as a part of this project. The front end will be very basic with log-in capabilities and e-mail template upload. Iteration 2.0 may include a message board for spammer communications.

### Iteration One

Wireframe website design with a user dashboard and CRUD out basic user login with Google OAuth.

### Iteration Two

Learn and write Chef. Write a simple Chef Recipe to automatically deploy a Ruby environment to AWS EC2. Test tear down and create functionality of the script.

``
Determine if automated server deployment is a feasible. (This step will determine the next iteration)
``
