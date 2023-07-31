# Generated by Django 3.2 on 2021-06-23 09:02

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0008_stolpersteinrelation'),
    ]

    operations = [
        migrations.AlterField(
            model_name='stolpersteinrelation',
            name='stolperstein',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='stolperstein_relations', to='api.stolperstein'),
        ),
        migrations.AlterField(
            model_name='stolpersteinrelation',
            name='text',
            field=models.TextField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name='stolpersteinrelation',
            name='type',
            field=models.CharField(choices=[('FAMILY', 'family member'), ('WORK', 'work colleague'), ('FRIEND', 'friend'), ('NEIGHBOUR', 'neighbour'), ('COMMUNITY', 'community'), ('OTHER', 'other')], default='OTHER', max_length=10),
        ),
    ]