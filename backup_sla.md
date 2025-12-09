# Backup SLA

## Coverage

We back up services that satisfy at least one of these criteria:
 - are primary source of truth for particular data
 - contain customer and/or client data
 - are not feasible (or very costly) to restore by other means

Services that are backed up:
 - MySQL database
 - Prometheus TSDB
 - Loki log files


## Schedule

MySQL full backups are created every Sunday and incremental backups every day; it takes up to 10 min to create and store the backup.

Prometheus full backups are created every Sunday and incremental backups every day; it takes up to 5 min to create and store the backup.

Loki full backups are created every Sunday and incremental backups every day; it takes up to 10 min to create and store the backup.

All backups are started automatically by cron.

Backup RPO (recovery point objective) is:
 - MySQL for 25 hours
 - Prometheus for 25 hours
 - Loki for 25 hours


## Storage

All aforementioned backups are uploaded to the backup server as plaintext.

Infrastructure ansible code is mirrored to the internal Git server.

Backup data from both servers will be synchronized to encrypted AWS S3 bucket in future (work in progress).


## Retention

MySQL backups are stored for 30 days; 30 versions (recovery points) are available to restore.

Prometheus backups are stored for 30 days; 30 versions are available to restore.

Loki backups are stored for 30 days; 30 versions are available to restore.


## Usability checks

All backups are verified every week by restoring them on dedicated virtual machines. This is an automated task, supervised by IT department.


## Restore process

Service is recovered from the backup in case of an incident, and when service cannot be restored in any other way.

RTO (recovery time objective) is:
 - MySQL for 1 hour
 - Prometheus for 1 hour
 - Loki for 1 hour

Detailed backup restore procedure is documented in the [backup_restore.md](./backup_restore.md).