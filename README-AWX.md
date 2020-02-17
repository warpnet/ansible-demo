# Getting started with AWX
If you have followed the workshop or have already a clear understanding of Ansible, you are ready to start to learn AWX. This README will cover a step by step tutorial on how to place the existing demo project in the folder `./ansible` in AWX.

This guide assumes that you have already run `vagrant up` and that you have successfully provisioned `web1, web2` as webservers and `lb` as a loadbalancer.

## Step by step guide
This section will guide you step by step on how to run the previously made the ansible playbooks and tasks into AWX. If you want to use your own Git instance you can skip the first parts of this tutorial and go to step 3.

1. **Provision Gitea**
```console
$ vagrant up gitea
[...]

TASK [Display Gitea access information] ****************************************
ok: [gitea] => {
    "msg": [
        "Gitea installation done!",
        "Access Gitea using the following url: http://192.168.50.15",
        "",
        "You will need to click on `register`",
        "Click install Gitea button, there is no need to make changes",
        "Create your account!"
    ]
}

PLAY RECAP *********************************************************************
gitea                      : ok=16   changed=13   unreachable=0    failed=0    skipped=0    rescued=0    ignored=
```

2. **You will be provided with some information on how to access Gitea. Browse to the URL and follow the steps:**
- Click on register
- Scroll down and click on "Install Gitea", do not edit any settings
- Again click on register
- Create your account and write down the username and password of your choosing
- Click the "+" sign to create a new repository, give the project a name. Click on "Create repository".

3. **You now have created a repository in Gitea (or on another Git instance of your choosing). First we need to start AWX.**
```console
$ vagrant up awx
[..]

    awx: =======================================================================
    awx: Provisioning of Ansible AWX completed!
    awx: You can access Ansible AWX via your web browser on your local machine:
    awx:
    awx: url:      http://192.168.50.11
    awx: username: admin
    awx: password: password
    awx: =======================================================================
```

4. **Browse to the URL and login using the provided information. First we need to create "machine credentials" to login using the vagrant user on the nodes. Follow these steps:**
- On the left side, click on credentials
- Click the "+" symbol
- Fill in name: "vagrant"
- Machine type: Machine
- Username: vagrant
- Paste the private key from `/home/vagrant/.ssh/id_rsa` in "SSH Private key" field
- Privilege escalation method: sudo
- Privilege escalation username: root
- Click save

5. **In the Credential tab we need to create credentials to access Git. Create a new credential using the following information:**
- Name: Git
- Machine type: Source Control
- Fill in the information to access your gitea (or other git instance)
- Click save

6. **Then push the ansible project to the Gitea (or other git instance). We will not cover on how to add the ansible project to a git instance.**

7. **Create a project in AWX to add the ansible project. Click on projects and create a new project using the following information:**
- Name: Ansible and Pizza
- SCM type: Git
- SCM URL: the url to the repository
- SCM Credentials: Git
- Click save

If you have done it right the circle will turn green.

8. **Create the inventory by clicking on inventories and the "+" sign. Then follow the following steps:**
- Give the inventory a name and click on save
- Click on groups and create the group: webservers, click on save
- Add the hosts for the group webservers (192.168.50.12 and 192.168.50.13). In the section extra variables add the following setting and give each host another color (e.g. `color: black`)
- Add another group called loadbalancer with the host 192.168.50.14

9. **At this point you have added the correct credentials, setup the project and added the inventory in AWX. The last step is to create a template and link it all together. Follow the following steps:**
- Click on the "+" sign -> "Job Template"
- Name: install_webservers
- Job type: run
- Inventory: the name of the inventory created in step 8
- Project: Ansible and Pizza (created in step 7)
- Playbook: install_webservers.yml
- Credentials: vagrant
- Leave the rest default and click save

10. **Now everything is linked together we can run the template! Click on the launch icon on the install_webservers template en verify the results. As you can can see the 2 webservers (web1 and web2) are receiving a new playbook run. if you applied other values in the `color` key (see step 8), the webpages are being updated to that new color!**

You just ran your first ansible playbook using Ansible AWX (Tower)! As a follow-up you can try and add your playbook for the loadbalancer in AWX or you can just browse through the UI and try different things out.

Documentation of Ansible AWX (Tower) can be found [here](https://docs.ansible.com/ansible-tower/index.html)
