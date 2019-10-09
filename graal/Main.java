import org.xml.sax.SAXException;

import javax.xml.XMLConstants;
import javax.xml.transform.stream.StreamSource;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import javax.xml.validation.Validator;
import java.io.File;
import java.io.IOException;

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
            Schema schema = factory.newSchema(new File(path));

            return schema.newValidator();
        } catch (SAXException e) {
            System.err.print("Unable to load XSD file: ");
            System.err.println(e.getMessage());
            System.exit(3);

            return null;
        }
    }

    private static boolean perform(Validator validator, String path) {
        try {
            validator.validate(new StreamSource(new File(path)));
            System.out.print("[OK  ] ");
            System.out.println(path);

            return true;
        } catch (SAXException | IOException e) {
            System.err.print("[FAIL] ");
            System.err.println(path);

            System.err.print("> ");
            System.err.println(e.getMessage());

            return false;
        }
    }
}
