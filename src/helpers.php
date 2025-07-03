<?php

if (!function_exists('slugify')) {
    function slugify(string $text): string
    {
        // Replace non-letter or digits by -
        $text = preg_replace('~[^\pL\d]+~u', '-', $text);

        // Transliterate (optional, depends on availability)
        if (function_exists('iconv')) {
            $text = iconv('utf-8', 'us-ascii//TRANSLIT', $text);
        }

        // Remove unwanted characters
        $text = preg_replace('~[^-\w]+~', '', $text);
        $text = trim($text, '-');
        $text = preg_replace('~-+~', '-', $text);
        $text = strtolower($text);

        return $text ?: 'n-a';
    }
}
