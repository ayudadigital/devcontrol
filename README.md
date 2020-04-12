# Development Environment Control Script

Simply dev env control script writen in BASH

## Objective

You may be tired of executing the same sentences in order, over and over again, to perform the same task.

The `devcontrol` script can help by calling your set of scripts that automate these tasks, such as starting or stopping services, loading initial data, putting everything together in a single dynamic management interface and allowing you to keep the focus on your development work.

## Installation

Open a console and execute:

```shell
curl https://raw.githubusercontent.com/tpbtools/devcontrol/master/install.sh | sudo bash
```

The `devcontrol` script will be installed in your `/usr/local/bin` directory.

## Create actions

You can add actions to your repository. Simply put one or more bash script files under the `devcontrol/actions` directory of your `git` repository with the `.sh` extension. Then execute `devcontrol` at the root of the repository.

In details:

1. Create a directory called `devcontrol/actions` at the root directory of your `git` repository and put whithin your action scripts (one bash script file per action, with the `.sh` extension).
2. Optionally, create another directory called `devcontrol/global` and put a bash script called `startup.sh` with your initialization variables and global functions.
3. Execute the `devcontrol` script in the root folder of your project.

The `devcontrol` script will collect the whole of your action scripts and put enable you to execute as parametrized options of the `devcontrol` script.

Find an example under `examples/docker` folder. Is a set of scripts to manage project driven by docker-compose.

```console
$ mkdir bin
$ rsync -avpP ~/devcontrol/devcontrol.sh bin
sending incremental file list
devcontrol.sh
          5,452 100%    0.00kB/s    0:00:00 (xfr#1, to-chk=0/1)

sent 5,574 bytes  received 35 bytes  11,218.00 bytes/sec
total size is 5,452  speedup is 0.97
$ rsync -avpP ~/devcontrol/examples/docker/devcontrol/ devcontrol/
sending incremental file list
created directory devcontrol
./
actions/
actions/destroy.sh
            889 100%    0.00kB/s    0:00:00 (xfr#1, to-chk=6/10)
actions/enter.sh
            974 100%  951.17kB/s    0:00:00 (xfr#2, to-chk=5/10)
actions/logs.sh
            810 100%  791.02kB/s    0:00:00 (xfr#3, to-chk=4/10)
actions/start.sh
            823 100%  803.71kB/s    0:00:00 (xfr#4, to-chk=3/10)
actions/status.sh
            885 100%  864.26kB/s    0:00:00 (xfr#5, to-chk=2/10)
actions/stop.sh
            814 100%  794.92kB/s    0:00:00 (xfr#6, to-chk=1/10)
global/
global/startup.sh
            654 100%  638.67kB/s    0:00:00 (xfr#7, to-chk=0/10)

sent 6,474 bytes  received 197 bytes  4,447.33 bytes/sec
total size is 5,849  speedup is 0.88
$ find devcontrol/
devcontrol/
devcontrol//actions
devcontrol//actions/logs.sh
devcontrol//actions/enter.sh
devcontrol//actions/status.sh
devcontrol//actions/destroy.sh
devcontrol//actions/stop.sh
devcontrol//actions/start.sh
devcontrol//global
devcontrol//global/startup.sh
$ bin/devcontrol.sh
Devcontrol Docker Example (c) 2019

Usage:
    - bin/devcontrol.sh help     # This information page
    - bin/devcontrol.sh destroy  # Environment removal
    - bin/devcontrol.sh enter    # Enter with a console to a service: 'app' (default), 'db' or 'duing'
    - bin/devcontrol.sh logs     # Show logs
    - bin/devcontrol.sh start    # Environment start and load initial data
    - bin/devcontrol.sh status   # Get status of the local docker development environment
    - bin/devcontrol.sh stop     # Platform stop

Use 'bin/devcontrol.sh help <action>' to display his help (e.g. bin/devcontrol.sh help destroy)

$ bin/devcontrol.sh help status
Devcontrol Docker Example (c) 2019

Help for the 'status' action

Execute the 'docker-compose ps' command
$ bin/devcontrol.sh status
Devcontrol Docker Example (c) 2019

      Name                   Command              State             Ports
----------------------------------------------------------------------------------
pedidos_app_1      /var/www/pedidos/bin/app.sh    Up       0.0.0.0:10080->80/tcp
pedidos_db_1       docker-entrypoint.sh mysqld    Up       0.0.0.0:13306->3306/tcp
pedidos_duing_1    /bin/bash /root/startup.sh     Up       0.0.0.0:13389->3389/tcp
pedidos_waiter_1   /usr/local/bin/entrypoint.sh   Exit 0
```

## Action scripts format

The `devcontrol` script will call your scripts with at least one parameter identified in the $1 variable within your script and one of the following texts:

- `brief`: Expect that the script will display one line with a summary exmplanation of the comand. It will be used in the action list (`devcontrol help`)
- `help`: Expect a multiline explanation. It will be used with the (`devcontrol help <action>`)
- `exec`: The statements of the action (`devcontrol <action>`). The script will receive parameters from the `devcontrol` script.

Take a look at the example actions under `examples/docker/actions` folder. Feel free to add your own examples as pull request to this project.

## Startup script format

It's up to you. It will be executed first, so you can put here the title of your project.

## Debug

Execute the script with `DC_DEBUG=1 devcontrol status` to help trace errors.

```console
$ DC_DEBUG=1 bin/devcontrol.sh
>>>> DEBUG >>>>> 2019-08-24 19:32:31 devcontrol: begin
>>>> DEBUG >>>>> 2019-08-24 19:32:31 devcontrol: Devcontrol (c) TIC para Bien 2019-2020
>>>> DEBUG >>>>> 2019-08-24 19:32:31 devcontrol: Startup
>>>> DEBUG >>>>> 2019-08-24 19:32:31 devcontrol: Execute delegate startup with 'devcontrol/global/startup.sh' script
Devcontrol Docker Example (c) 2019

>>>> DEBUG >>>>> 2019-08-24 19:32:31 devcontrol: Load action list from 'devcontrol/actions' directory
>>>> DEBUG >>>>> 2019-08-24 19:32:31 devcontrol: - Found action 'destroy'
>>>> DEBUG >>>>> 2019-08-24 19:32:31 devcontrol: - Found action 'enter'
>>>> DEBUG >>>>> 2019-08-24 19:32:31 devcontrol: - Found action 'logs'
>>>> DEBUG >>>>> 2019-08-24 19:32:31 devcontrol: - Found action 'start'
>>>> DEBUG >>>>> 2019-08-24 19:32:31 devcontrol: - Found action 'status'
>>>> DEBUG >>>>> 2019-08-24 19:32:31 devcontrol: - Found action 'stop'
>>>> DEBUG >>>>> 2019-08-24 19:32:31 devcontrol: Located 6 actions
Usage:
    - bin/devcontrol.sh help     # This information page
    - bin/devcontrol.sh destroy  # Environment removal
    - bin/devcontrol.sh enter    # Enter with a console to a service: 'app' (default), 'db' or 'duing'
    - bin/devcontrol.sh logs     # Show logs
    - bin/devcontrol.sh start    # Environment start and load initial data
    - bin/devcontrol.sh status   # Get status of the local docker development environment
    - bin/devcontrol.sh stop     # Platform stop

Use 'bin/devcontrol.sh help <action>' to display his help (e.g. bin/devcontrol.sh help destroy)
```
