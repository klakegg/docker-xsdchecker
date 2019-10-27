package net.klakegg.xsdchecker;

import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;

import javax.xml.XMLConstants;
import javax.xml.transform.stream.StreamSource;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import javax.xml.validation.Validator;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URL;

/**
 * @author erlend
 */
public class Main {

    public static void main(String... args) {
        if (args.length < 2) {
            System.out.println("Arguments: [xsd file] [xml file...]");
            System.exit(2);
        }
        Validator validator = prepare(args[0]);

        boolean success = true;
        for (int i = 1; i < args.length; i++)
            if (!perform(validator, args[i]))
                success = false;

        System.exit(success ? 0 : 1);
    }

    private static Validator prepare(String path) {
        try {
            SchemaFactory factory = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
            Schema schema;

            if (path.startsWith("http")) {
                schema = factory.newSchema(new URL(path));
            } else {
                schema = factory.newSchema(new File(path));
            }

            return schema.newValidator();
        } catch (SAXException | IOException e) {
            System.err.print("Unable to load XSD file: ");
            System.err.println(e.getMessage());
            System.exit(3);

            return null;
        }
    }

    private static boolean perform(Validator validator, String path) {
        if (path.contains("*")) {
            return performGlob(validator, path);
        } else {
            return perform(validator, new File(path));
        }
    }

    private static boolean performGlob(Validator validator, String path) {
        boolean result = true;

        try {
            for (File file : ExtraFiles.glob(path))
                if (!perform(validator, file))
                    result = false;
        } catch (IOException e) {
            System.err.print("Unable to find files using glob: ");
            System.err.println(e.getMessage());
            System.exit(5);
        }

        return result;
    }


    private static boolean perform(Validator validator, File path) {
        try {
            validator.validate(new StreamSource(path));
            System.out.print("[OK  ] ");
            System.out.println(path);

            return true;
        } catch (FileNotFoundException e) {
            err(path, "File not found");
        } catch (SAXParseException e) {
            err(path, String.format("%s:%s - %s", e.getLineNumber(), e.getColumnNumber(), e.getMessage()));
        } catch (SAXException | IOException e) {
            err(path, e.getMessage());
        }

        return false;
    }

    private static void err(File path, String message) {
        System.err.print("[FAIL] ");
        System.err.println(path);

        System.err.print("> ");
        System.err.println(message);
    }
}
