var press_left = keyboard_check(vk_left) || keyboard_check(ord("A"));
var press_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
var press_up = keyboard_check(vk_up) || keyboard_check(ord("W"));
var press_down = keyboard_check(vk_down) || keyboard_check(ord("S"));

// 1. Récupérer les entrées brutes (-1, 0, ou 1)
var _input_x = press_right - press_left
var _input_y = press_down -press_up

// 2. Calculer la direction et la longueur du vecteur
if (_input_x != 0 || _input_y != 0) {
    // On récupère l'angle de la saisie clavier
    var _input_dir = point_direction(0, 0, _input_x, _input_y);
    
    var _iso_dir = _input_dir + 45; 

    // 3. Conversion en vecteurs de grille (i, j)
    // lengthdir_x/y nous donne un vecteur normalisé (longueur 1) projeté sur les axes
    var _move_i = lengthdir_y(1, _iso_dir); 
    var _move_j = lengthdir_x(1, _iso_dir);

    // 4. Application du mouvement fluide
    f_i += _move_i * move_speed;
    f_j += _move_j * move_speed;
}

// On détermine sur quelle tuile "sol" il se trouve (pour la hauteur)
// On arrondit pour savoir au-dessus de quelle case on survole
var _current_i = round(f_i);
var _current_j = round(f_j);

// Gestion de la hauteur (Z)
// On récupère la hauteur de la map à cet endroit
var _ground_z = obj_world.floor_at_i_j(_current_i, _current_j);
var _target_k = _ground_z + 1;

// Interpolation de la hauteur (optionnel, pour que le joueur ne "snappe" pas verticalement)
// Sinon : k = _target_k;
k = _target_k;

var _pos = obj_world.map_to_screen(f_i, f_j, k);
x = _pos.x;
y = _pos.y;