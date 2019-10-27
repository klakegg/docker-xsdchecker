package net.klakegg.xsdchecker;

import java.io.File;
import java.io.IOException;
import java.nio.file.*;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author erlend
 */
public interface ExtraFiles {

    static List<File> glob(String path) throws IOException {
        PathMatcher pathMatcher = FileSystems.getDefault().getPathMatcher(String.format("glob:%s", path));

        String tmpPath = path.substring(0, path.indexOf('*'));
        tmpPath = tmpPath.lastIndexOf('/') == -1 ? "" : tmpPath.substring(0, tmpPath.lastIndexOf('/'));

        Path folder = Paths.get(tmpPath);

        if (Files.notExists(folder)) {
            System.err.println(String.format("Unable to find '%s'.", folder.toAbsolutePath()));
            return Collections.emptyList();
        }

        return Files.walk(folder)
                .filter(pathMatcher::matches)
                .sorted()
                .map(Path::toFile)
                .collect(Collectors.toList());
    }
}
