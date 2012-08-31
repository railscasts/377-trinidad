# RailsCasts Episode #377: Trinidad

http://railscasts.com/episodes/377-trinidad

Requires Ruby 1.9.2 or higher.


### Commands used in this episode

```
ssh root@198.58.96.26
adduser deployer
echo "deployer ALL=(ALL:ALL) ALL" >> /etc/sudoers
exit
ssh-copy-id deployer@198.58.96.26
cap deploy:install
cap deploy:setup
cap deploy:cold
bundle exec rails s trinidad -e production
cap nginx:setup
cap trinidad:setup
touch tmp/restart.txt
cap deploy trinidad:restart
```

### Gotchas

* **Highline Version:** If you are using JRuby 1.7 and receiving the exception `NameError: cannot load Java class jline.ConsoleReader` while running Capistrano commands then try running `bundle update highline`. This was fixed in Highline version to 1.6.14. See [this issue](https://github.com/JEG2/highline/issues/41) for details.

* **SSH Agent Forwarding:** If Capistrano hangs while deploying, check to see if the `ssh_options[:forward_agent] = true` is in the Capistrano config. This may not work as [discussed here](http://jira.codehaus.org/browse/JRUBY-6181). Here are some solutions.

  * Authorize the server directly by generating an SSH key and setting it up as [the deploy key](https://help.github.com/articles/managing-deploy-keys).

  * Consider running Capistrano commands from Ruby MRI on your local.

  * Use an alternative deployment method such as "copy"

  * Try upgrading to JRuby 7 on your local machine, this has been reported to solve the issue but I have not tested it.

* **Not Reloading:** I experienced an issue where running `touch tmp/restart.txt` on the server would not use the latest code. Unfortunately I was unable to reproduce this problem consistently enough to resolve it. If you experience this, please [comment on this issue](https://github.com/trinidad/trinidad/issues/84).
