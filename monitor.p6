#!/usr/bin/env perl6
# tempoℝæl orientation
# good for sleep, study, work, play, ETC

; use v6.c

################################################################
# http://matrix.wikia.com/wiki/Prime_Program                   #
################################################################

; my $database = {; $_ = $*PROGRAM-NAME; s/p6$/log/; $_}()
; my $configuration = {; $_ = $*PROGRAM-NAME; s/p6$/cfg/; $_}()

# wibbly wobbly, timey wimey; who is the ~~ of them all? timezones are irrelevant anyway...
; my $time = '0003-03-03T03:03:03' # '0003-03-03T03:03:03'
; my $then = DateTime.new($time)
; my $now = DateTime.new(now)
; my $seconds = $now-$then
; my $minutes = $seconds÷60
; my $hours = $minutes÷60
; my $days = $hours÷24
; my @time := $seconds, $minutes, $hours, $days
; "\ec".print
; @time.map({
	; say
		.VAR.name.substr(1).wordcase.fmt('%-7s: ')
		~ .Int().fmt("%.{@time.map({
			# hopefully this will be memoised
			; .Int().chars
		}).max}d")
		~ ($_%1).fmt('%.3f').substr(1)
})

# expect "sleep", or any"-thing" else; not sleeping means awake
; my $query = prompt "\nWhat have you \$pent all this time on? "
; prompt "\nWell, I hope it was worth it; you won't be getting a refund!"

# update $time
; my $name = $*PROGRAM-NAME
; my $self-modifying_code = slurp $name
; $self-modifying_code ~~ s/('; my $time = \'')(.*?)('\'')/$0$now$2/
; spurt $name, $self-modifying_code

# update $database
; spurt $database, "$seconds $query\n" ~ slurp $database

################################################################
# reminders                                                    #
################################################################

; my $data = slurp $database
; my @data = $data.split("\n").map({.split(' ')})
; print "\nreminders:\n"
; datamine | $_ for EVALFILE $configuration

################################################################
# escape                                                       #
################################################################

# I should be able to just use one of these: escape \e \033 ^[ \u001b \x1b \0x1b \b11011 \0b11011 \d27 \0d27 \27 ETC
; exit

################################################################
# subroutines                                                  #
################################################################

; sub datamine($pattern, @r) {
	# add seconds from top of database to find time between $now & $seconds time
	; my @reminders = @r.sort.reverse
	; my $seconds = @reminders[0][0]
	; my $s = 0
	; @data.map({
		# $query ~~ $pattern
		; if .cache.join(" ") !~~ $pattern {
			; $s += $_[0]
			; last if $seconds < $s
		} else {last}
	})
	# $y = [[$s<=60×60, ''], [60×60<=$s, 'do the "-thing"!']]
	; @reminders.map({; if $_[0] <= $s {; say $_[1]; last}})
}
