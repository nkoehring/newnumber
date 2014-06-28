newnumber
=========

Got a new phone number you want to share with people who know your old one?


prerequisites
-------------

You need [ruby](https://www.ruby-lang.org/) and [sinatra](https://www.sinatrarb.com/) and [haml](https://www.haml-lang.com/) and [sass](https://www.sass-lang.com/).


run
---

To run, just write a file config.production.yaml in the format:

```
config:
  newNumber: +491234567890
  oldNumber: +490987654321
```

and run the server with:

`RACK_ENV=production ruby newnumber.rb`
