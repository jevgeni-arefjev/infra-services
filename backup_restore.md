# Restore database from backup server

## Make sure the server and the services on it are up and operational

Install and configure infrastructure with Ansible:

    ansible-playbook infra.yaml

## Run following commands on server where MySQL is running

Escalate the privileges:

    sudo su -

You can check if the server is correct and MySQL is operational:

    service mysql status

Make sure /home/backup/restore directory is empty:

    rm -r /home/backup/restore/

Restore MySQL data from the backup:

    sudo -u backup duplicity --no-encryption restore rsync://jevgeni-arefjev@backup/mysql /home/backup/restore

    mysql agama < /home/backup/restore/agama.sql

### Check if data is restored

1) Command line did not give any errors.
2) The data saved at the moment of last backup is available in the web browser application.

<br/>
<br/>
<br/>

-----

# Restore Prometheus TSDB from backup server

## Make sure the server and the services on it are up and operational

Install and configure infrastructure with Ansible:

    ansible-playbook infra.yaml

## Run following commands on server with prometheus

Escalate the privileges:

    sudo su -

You can check if the server is correct and prometheus is operational:

    service prometheus status

Restore prometheus snapshot from the backup:

    sudo -u backup duplicity --no-encryption restore rsync://jevgeni-arefjev@backup/prometheus /home/backup/restore --no-restore-ownership

Stop prometheus:

    service prometheus stop

Make sure /home/backup/restore and /var/lib/prometheus/metrics2 directories are empty:

    rm -r /home/backup/restore/

    rm -r /var/lib/prometheus/metrics2/

Prometheus snapshot has a name starting with the date, 2025 for example. Use autocomplete to find that snapshot:
    
    mv /home/backup/restore/2025...{use autocomplete}/* /var/lib/prometheus/metrics2/

    chown -R prometheus:prometheus /var/lib/prometheus/metrics2/

    service prometheus start
    

### Check if data is restored

1) Command line did not give any errors.
2) The data saved at the moment of last backup is available in the prometheus application.

<br/>
<br/>
<br/>

-----

# Restore Loki logs from backup server

## Make sure the server and the services on it are up and operational

Install and configure infrastructure with Ansible:

    ansible-playbook infra.yaml

## Run following commands on server with loki

Escalate the privileges:

    sudo su -

You can check if the server is correct and loki is operational:

    service loki status

Make sure /home/backup/restore directory is empty:

    rm -r /home/backup/restore/

Restore Loki logs from the backup:

    sudo -u backup duplicity --no-encryption restore rsync://jevgeni-arefjev@backup/loki /home/backup/restore
    
    service loki stop

    rm -r /var/lib/loki/*

    mv /home/backup/restore/* /var/lib/loki/

    chown -R nobody:nogroup /var/lib/loki

    service loki start

### Check if data is restored

1) Command line did not give any errors.
2) The data saved at the moment of last backup is available in the prometheus application.
