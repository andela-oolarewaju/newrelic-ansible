# newrelic-ansible
Clone this repo: 

```git clone https://github.com/andela-oolarewaju/newrelic-ansible.git ```

Then:

```$ cd newrelic-ansible```

Create a ```vars.yml``` file and put the following variables like:
```
app_dir: "<application-directory-name>"
repo_name: "<app-repo-url>"
app_name: "['<app-name>'],"
license_key: "'<license-key-from-newrelic'"
startup_script: "<startup-script>"
```

This file **SHOULD NOT** be public

Replace the IP and the path to private key in the `inventory.ini` file with the public ip and path to private key of your server

**RUN** `ansible-playbook -i inventory.ini playbook.main.yml` to run the scripts 

**TO TEST**

Create a `vars.rb file in the `features/step_definitions/ directory and add the variables that our tests will need:

```
PATHTOPRIVATEKEY = "<path/to/private/key>"
PUBDNS = "<publicdns>" #example: ubuntu@ec2-11-22-33-44.compute-1.amazonaws.com
APPDIR = "<path/to/app/directory>"
```

Then run `cucumber features/install.feature`