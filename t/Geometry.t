#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use Test::Deep;
use DDG::Test::Goodie;
use utf8;

zci answer_type => "geometry";
zci is_cached   => 1;

# Build a structured answer that should match the response from the Perl file
sub build_structured_answer {
    my ( $title, $formulas, $svg ) = @_;

	return "plain text response", structured_answer => {
        data => {
            title    => ucfirst($title),
            formulas => $formulas,
            svg      => $svg,
        },

        templates => {
            group   => "text",
            options => {
                subtitle_content => 'DDH.geometry.subtitle'
            }
        }
    };
}

# Use this to build expected results for your tests.
sub build_test { test_zci( build_structured_answer(@_) ) }

ddg_goodie_test(
    [qw( DDG::Goodie::Geometry )],

    # First Param = Name of object
    # Second Param = Array of formula objects for expected object
    # Third Param = SVG of expected object

    'geometry of a square' => build_test(
        'square',
        {
            area =>      { color => "#F1A031", html => "a<sup>2</sup>", nameCaps => "Area",       symbol => "A" },
            diagonal =>  { color => "#4495D4", html => "a√2",           nameCaps => "Diagonal",   symbol => "e" },
            perimeter => { color => "#5B9E4D", html => "4a",            nameCaps => "Perimeter",  symbol => "u" }
        },
        '<path d="M 0,0 h 120 v 120 h -120 z" class="stroke area" data-type="area"></path> <path d="M 0,0 h 120 m 0,120 h -120 m 120,0 v -120 m -120,0 v 120" class="stroke perimeter" data-type="perimeter"></path> <path d="M 0,0 l 120,120" class="stroke special diagonal" data-type="diagonal"></path>',
    ),

    'area of a square' => build_test(
        'square',
        {
            area =>      { color => "#F1A031", html => "a<sup>2</sup>", nameCaps => "Area",       symbol => "A" },
            diagonal =>  { color => "#4495D4", html => "a√2",           nameCaps => "Diagonal",   symbol => "e" },
            perimeter => { color => "#5B9E4D", html => "4a",            nameCaps => "Perimeter",  symbol => "u" }
        },
        '<path d="M 0,0 h 120 v 120 h -120 z" class="stroke area" data-type="area"></path> <path d="M 0,0 h 120 m 0,120 h -120 m 120,0 v -120 m -120,0 v 120" class="stroke perimeter" data-type="perimeter"></path> <path d="M 0,0 l 120,120" class="stroke special diagonal" data-type="diagonal"></path>',
    ),
    'volume of sphere' => build_test(
        'sphere',
        {
            volume =>   { color => "#DE5833", html => "4/3πr<sup>3</sup>", nameCaps => "Volume",    symbol => "V" },
            surface =>  { color => "#F1A031", html => "4πr<sup>2</sup>",   nameCaps => "Surface",   symbol => "S" },
        },
        '<path d="M 0,60 a 25 25 0 0 0 120,0 a 25 25 0 0 0 -120,0" class="fill surface" data-type="surface"></path> <path d="M 0,60 a 30 10 0 0 1 120,0" class="stroke backface"></path> <path d="M 0,60 a 30 10 0 0 1 120,0" class="stroke backface" data-type="volume"></path> <path d="M 0,60 a 30 10 0 1 0 120,0 a 25 25 0 0 0 -120,0 a 25 25 0 0 0 120,0" class="stroke volume" data-type="volume"></path>',
    ),
    # Does Not match to
    'calc banana' => undef,
    'formula of shirt' => undef,
    '' => undef,
    ' ' => undef,
);

done_testing;
