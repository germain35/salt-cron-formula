{%- from "cron/map.jinja" import cron with context %}

{%- for user, params in cron.items() %}
  {%- for k, v in params.get('env', {}).items() %}
cron_{{user}}_env_{{k}}:
  cron.env_present:
    - name: {{k}}
    - value: {{v}}
    - user: {{user}}
  {%- endfor %}
  {%- for k, v in params.get('jobs', {}).items() %}
cron_{{user}}_job_{{k}}:
  cron.present:
    - identifier: {{k}}
    - name: {{v.name}}
    - user: {{user}}
    {%- if v.special is defined %}
    - special: {{v.special}}
    {%- else %}
      {%- if v.daymonth is defined %}
    - daymonth: {{v.daymonth}}
      {%- endif %}
      {%- if v.month is defined %}
    - month: {{v.month}}
      {%- endif %}
      {%- if v.dayweek is defined %}
    - dayweek: {{v.dayweek}}
      {%- endif %}
      {%- if v.hour is defined %}
    - hour: {{v.hour}}
      {%- endif %}
      {%- if v.minute is defined %}
    - minute: {{v.minute}}
      {%- endif %}
    {%- endif %}
  {%- endfor %}
{%- endfor %}
