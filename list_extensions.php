<?php

$extensions = [];

foreach (get_loaded_extensions() as $extension) {
    $reflection = new ReflectionExtension($extension);

    $extensions[$extension] = $reflection->getVersion();
}

ksort($extensions);

echo var_export($extensions, true);
?>