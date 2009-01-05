Helm – a command line tool for Lighthouse
=========================================

_Disclaimer_: This is alpha software. Seriously. Expect breakages and changes in the way configuration is made. We'll do our best to alert you and keep things as backwards-compatible as possible.

Lighthouse is pretty cool, but it'd be nice if we had a way to interact with it from the command line.

Configuration
-------------

Although Helm can receive all the parameters it needs from the command line, usually you'll want to use the configuration files. Our recommended usage is that you have a `.helm_config` in your home directory, where you store your Lighthouse credentials, and another `.helm_config` that lives in the root of your project's directory (this file contains general information about the project and can be pushed to your SCM of choice.

1. Edit `~/.helm_config` and add your credentials for the account. You can provide a token (recommended) or your username and password (this is necessary if you want to use scraping commands like `upload`).

        http://your-account.lighthouseapp.com:
          token: your API token
          username: username
          password: password

2. Edit your project's `.helm_config`.

        url: http://your-account.lighthouseapp.com
        project: "Your project's full name"

3. Try it.

        $ helm list

Commands
--------

This *will* change.

### `helm list` ###
  
Examples:

    $ helm list
    $ helm list state:open
    $ helm list "responsible:me state:open"

### `helm create` ###

Parses STDIN and creates tickets.

Examples:

    $ echo "As a User I want a UI" | helm create
    $ cat stories.txt | helm create

### `helm show` ###

Displays information about a ticket.

Examples:

    $ helm show 13

### `helm assign` ###

Changes the assignee of a ticket. If no user is provided, assign to self.

Examples:

    $ helm assign 13
    $ helm assign 13 [Lighthouse user ID]


Contributing
-------------
Please report bugs, submit feedback and patches to [http://helm.lighthouseapp.com/projects/22826-helm](http://helm.lighthouseapp.com/projects/22826-helm)
