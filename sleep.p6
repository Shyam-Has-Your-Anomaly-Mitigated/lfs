#!/usr/bin/env perl6
# tempoℝæl orientation
# good for sleep, study, work, play, ETC

# wibbly wobbly, timey wimey; who is the ~~ of them all? timezones are irrelevant anyway...
; my $time = "2018-03-31T00:07:57.867861Z"
; my $then = DateTime.new($time)
; my $now = DateTime.new(now)
; my $seconds = $now - $then
; my $minutes = $seconds/60
; my $hours = $minutes/60
; my $days = $hours/24
; print
	"seconds: $seconds\n"
	~ "minutes: $minutes\n"
	~ "hours  : $hours\n"
	~ "days   : $days\n"

# expect "sleep", or any"-thing" else; not sleeping means awake
; my $query = prompt "\nwhat have you \$pent all this time on? "
; print "well, I hope it was worth it; you won't be getting a refund!\n"

# update $time
; my $name = "$*PROGRAM-NAME"
; my $self-modifying_code = slurp "$name"
; $self-modifying_code ~~ s/('; my $time = "')(.*?)('"')/$0$now$2/
; spurt "$name", $self-modifying_code

# update database
; $name ~~ s/p6$/log/
; spurt "$name", (slurp "$name") ~ "$seconds $query\n"
