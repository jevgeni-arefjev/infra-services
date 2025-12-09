# Restore database from backup server

## Make sure the server and the services on it are up and operational

Install and configure infrastructure with Ansible:

    ansible-playbook infra.yaml

## Run following commands on server where MySQL is running

You can check if the server is correct and MySQL is operational:

    service mysql status

Make sure /home/backup/restore directory is empty:

    rm -r /home/backup/restore/*

Restore MySQL data from the backup:

    sudo -u backup duplicity --no-encryption restore rsync://jevgeni-arefjev@backup/mysql /home/backup/restore
    sudo su -
    mysql agama < /home/backup/restore/agama.sql
    exit

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


You can check if the server is correct and MySQL is operational:

    service prometheus status

Make sure /home/backup/restore directory is empty:

    rm -r /home/backup/restore/*

Prometheus snapshot has a name starting with the date, 2025 for example.
Restore prometheus snapshot from the backup:

    sudo -u backup duplicity --no-encryption restore rsync://jevgeni-arefjev@backup/prometheus /home/backup/restore --no-restore-ownership
    sudo su -
    mv /home/backup/restore/2025...{use autocomplete}/* /var/lib/prometheus/metrics2/
    chown -R prometheus:prometheus /var/lib/prometheus/metrics2/
    service prometheus start
    exit

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


You can check if the server is correct and MySQL is operational:

    service loki status

Make sure /home/backup/restore directory is empty:

    rm -r /home/backup/restore/*

Restore Loki logs from the backup:

    sudo -u backup duplicity --no-encryption restore rsync://jevgeni-arefjev@backup/loki /home/backup/restore
    sudo su -
    service loki stop
    rm -r /var/lib/loki/*
    mv /home/backup/restore/* /var/lib/loki/
    chown -R nobody:nogroup /var/lib/loki
    service loki start
    exit

### Check if data is restored

1) Command line did not give any errors.
2) The data saved at the moment of last backup is available in the prometheus application.
