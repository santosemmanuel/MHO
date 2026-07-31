from django.db import models

# Create your models here.
class PatientRecord(models.Model):
    # ID is set explicitly as AutoField for MySQL AUTO_INCREMENT primary key
    id = models.AutoField(primary_key=True)

    # Standard names mapping to camelCase database columns via db_column
    first_name = models.CharField(max_length=100, db_column='firstName')
    middle_name = models.CharField(max_length=100, blank=True, null=True, db_column='middleName')
    last_name = models.CharField(max_length=100, db_column='lastName')
    name_ext = models.CharField(max_length=10, blank=True, null=True, db_column='nameExt')  # Jr., Sr., III, etc.

    barangay = models.CharField(max_length=100, db_column='Barangay')
    pin = models.CharField(max_length=50, db_column='PIN')
    membership = models.CharField(max_length=50, db_column='Membership')

    day_0 = models.DateField(blank=True, null=True, db_column='Day0')
    date_and_time = models.DateTimeField(auto_now_add=True, db_column='DateandTime')

    class Meta:
        db_table = 'patient_records'  # Explicit MySQL table name
        verbose_name = 'Member Record'
        verbose_name_plural = 'Member Records'

    def __str__(self):
        return f"{self.last_name}, {self.first_name} - {self.pin}"