{% if params.W_FLOW=='canary' %}
UPDATE `xxl-job`.XXL_JOB_QRTZ_TRIGGER_GROUP set address_type=1,address_list='{{ansible_ssh_host}}:{{item.1.port_xxl_job}}'  WHERE app_name='{{job_name}}';
DELETE FROM `xxl-job`.XXL_JOB_QRTZ_TRIGGER_REGISTRY WHERE registry_key='{{job_name}}';
{% else %}
UPDATE `xxl-job`.XXL_JOB_QRTZ_TRIGGER_GROUP set address_type=0  WHERE app_name='{{job_name}}';
DELETE FROM `xxl-job`.XXL_JOB_QRTZ_TRIGGER_REGISTRY WHERE registry_key='{{job_name}}';
{% endif%}
