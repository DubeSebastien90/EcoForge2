cycle_time += cycle_speed;
if (cycle_time > 1) cycle_time = 0;

// On utilise une courbe (sinus) pour passer doucement du jour à la nuit
// On obtient une valeur entre 0 (jour) et 0.8 (nuit noire)
var _darkness = abs(sin(cycle_time * pi)) * 0.8; 
current_darkness = _darkness;