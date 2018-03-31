#!/usr/bin/env perl6
# tempoℝæl orientation
# good for sleep, study, work, play, ETC

################################################################
# http://matrix.wikia.com/wiki/Prime_Program                   #
################################################################

# wibbly wobbly, timey wimey; who is the ~~ of them all? timezones are irrelevant anyway...
; my $database = $*PROGRAM-NAME
; $database ~~ s/p6$/log/
; my $time = '2018-03-31T12:51:22.637116Z'
; my $then = DateTime.new($time)
; my $now = DateTime.new(now)
; my $seconds = $now - $then
; my $minutes = $seconds/60
; my $hours = $minutes/60
; my $days = $hours/24
; my @time := $seconds, $minutes, $hours, $days
; @time.map({
	; say
		.VAR.name.substr(1).wordcase.fmt('%-7s: ')
		~ Int($_).fmt("%.{@time.map({
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

# have you slept for 1×8×60×60 seconds in the last 2×8×60×60 seconds?
# zzz is a good one; a very unix-like TLA
; my $sleep_t = 2×8×60²
; my $sleep_p = /^.*(slept|sleep(ing)?|(snooz|snor)(e|ing)|(lucid )?dream(s|ing)?|zzz).*$/
; datamine $sleep_t, $sleep_p, [
	[$sleep_t, 'you should sleep!']
	, [$sleep_t-60², 'are you tired?']
]

# have you drank in the last 1×60×60 seconds?
; my $thirst_t = 60²
; my $thirst_p = /^.*(water|drank|drink|(re)?hydrate).*$/
; datamine $thirst_t, $thirst_p, [
	[$thirst_t*3, 'you should drink water!']
	, [$thirst_t, 'are you thirsty?']
]

# have you eaten in the last 1×60×60 seconds?
# what did you eat, how much, and what was in it?
# did you get enough $x nutrition?
; my $hunger_t = 60²
; my $hunger_p = /^.*(food|ate|eat(en)?|hunger).*$/
; datamine $hunger_t, $hunger_p, [
	[$hunger_t*3, 'you should eat!']
	, [$hunger_t, 'are you hungry?']
]

################################################################
# escape                                                       #
################################################################

# I should be able to just use one of these: escape \e \033 ^[ \u001b \x1b \0x1b \b11011 \0b11011 \d27 \0d27 \27 ETC
; exit

################################################################
# subroutines                                                  #
################################################################

; sub datamine($seconds, $pattern, @reminders) {
	# add seconds from top of database to find time between $now & $seconds time
	; my $s = 0
	; my @d
	; @data.map({
		# $query ~~ $pattern
		; if (.cache.join(" ")) !~~ $pattern {
			; $s += $_[0]
			; @d.append($_)
		} else {last}
		; last if $seconds < $s
	})
	# $y = [[$s<=60×60, ''], [60×60<=$s, 'do the "-thing"!']]
	; my $short_circuit = True
	; @reminders.map({
		; if $_[0] <= $s and $short_circuit {
			; say $_[1]
			; $short_circuit = False
		}
	})
}
