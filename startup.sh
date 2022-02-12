#! /bin/bash
sudo apt-get update
sudo apt-get install apache2 -y
sudo apt-get install php -y
sudo apt-get install wget -y
sudo rm /var/www/html/index.html
wget https://gist.githubusercontent.com/kkrishnan90/fd19913589cf2e6ca91b8ce5059226ca/raw/43263e747ed3433c116adc903e4056994f4de8dc/index.php
# sudo gsutil cp gs://lb-mig-bucket/index.php /var/www/html/index.php
sudo cp index.php /var/www/html/index.php
sudo service apache2 restart
