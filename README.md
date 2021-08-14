# Telebot Template

```bash
$ git clone https://github.com/massbots/template .
$ chmod +x init.sh; ./init.sh
NOTE The script will delete itself after the configuration.

Project name: ssvideo
Module path: go.massbots.xyz/ssvideo

Dialect (sqlite3|mysql|postgres): postgres
Driver (github.com/lib/pq):
```

## Overview

A basic [`telebot.v3`](https://github.com/tucnak/telebot/tree/v3) template is used for most of our bots. There are two ways of organizing the root, and this one use a simpler layout, without separating on `pkg` and `internal` directories, and keeping every package in the root. But, in the huge projects, where we may have lots of packages as has to be hidden, as exposed, the separation becomes really useful and much more convenient.

So, this is a good example of structuring your advanced bot, when there is too much code for an ordinary `main.go` file.

## Directories

### `/`

The root package, with the name of the module, usually should contain highly generic information. We store the `Bootstrap` structure here, which defines the basic dependencies required for a successful application performing.

### `/locales`

This directory consists of bot locales in `*.yml` files respectively to the telebot/layout format. If you don't need localization in your project, leave a single file and specify its locale code in `lt.DefaultLocale("..")` call.


### `/sql`

Optional, if you don't use a relational database. It's a directory of `*.sql` files, formatted in a way to use with `goose` migration tool.

### `/cmd`

Main binaries for the project. The directory name for each application should match the name of the executable you want to have. We use `/cmd/bot` for the bot's primary executable.

### `/bot`

Obviously, the core of the bot. Imports root's `Bootstrap` to initialize itself. It has all the handlers and bot behavior, logically grouped by the files. We also store custom middlewares here in `bot/middle` subpackage.

For example, imagine your bot has some settings that open as an inline menu on `settings` command. There are several parameters to be configured, let's say the user's name and delivery address. Where you should put this logic? The best place is `settings.go` file in the `bot` package with three functions inside, which are responsible for sending settings menu, asking for a new value to update, and actual updating operation of the specific setting. That way we have three ascending actions relying on each other, and it makes them intuitive by gathering in one place.

### `/database`

A wrapper to simplify the communication with your database. If you're ok with using ORM in your projects, then most likely there is no need for you in this package.