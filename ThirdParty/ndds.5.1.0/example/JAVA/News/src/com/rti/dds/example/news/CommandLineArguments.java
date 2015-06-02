// ***************************************************************************
//         (c) Copyright, Real-Time Innovations, All rights reserved.
//
//         Permission to modify and use for internal purposes granted.
// This software is provided "as is", without warranty, express or implied.
//
// ***************************************************************************

package com.rti.dds.example.news;


// ***************************************************************************

/**
 * A container for the running options (defined through the command-line 
 * arguments). This class is used by the News class.
 */
/*package*/ class CommandLineArguments {
    // -----------------------------------------------------------------------
    // Fields
    // -----------------------------------------------------------------------

    // --- Domain ID: --------------------------------------------------------

    private static final int DEFAULT_DOMAIN_ID = 0;

    /**
     * The maximum value for Domain ID. The effective value depends on the
     * QoS, in particular to the value of the field
     * <code>RtpsWellKnownPorts_t.domain_id_gain</code>.
     * The default value is 250, so we just limit to that statically so we
     * can check the validity before attempting to create the domain
     * participant.
     */
    private static final int DOMAIN_ID_MAX = 250;

    public int domainId = DEFAULT_DOMAIN_ID;


    // --- Mode (publisher or subscriber): -----------------------------------

    public static final int APP_MODE_UNDEFINED  = 0;
    public static final int APP_MODE_PUBLISHER  = 1;
    public static final int APP_MODE_SUBSCRIBER = 2;

    public int mode = APP_MODE_UNDEFINED;


    // --- Other fields: -----------------------------------------------------

    /**
     * The number of seconds for which this application should run.
     */
    public int runSeconds = 20;

    /**
     * 0 = no verbose, 1 = app verbose, 2 = DDS
     */
    public int verbose = 0;

    /**
     * If the subscribing application is using a content-based filter to
     * down-sample the incoming data, the filter expression will be stored
     * here.
     */
    public String contentFilter = null;



    // -----------------------------------------------------------------------
    // Public Methods
    // -----------------------------------------------------------------------

    public static CommandLineArguments parseArguments(String[] argv)
    throws ArgumentParseException {
        CommandLineArguments args = new CommandLineArguments();
        try {
            if (argv.length == 0) {
                System.err.println(
                        "! Invalid arguments.\n" +
                        "! You must specify at least running mode (pub/sub)");
                throw new ArgumentParseException();
            }

            // Parse the command: pub or sub
            if (argv[0].equalsIgnoreCase("pub")) {
                args.mode = CommandLineArguments.APP_MODE_PUBLISHER;
            } else if (argv[0].equalsIgnoreCase("sub")) {
                args.mode = CommandLineArguments.APP_MODE_SUBSCRIBER;
            } else if (argv[0].equals("-h") || argv[0].equals("--help")) {
                usage();
                return null;
            } else {
                System.err.println("! Invalid mode: " + argv[0]);
                System.err.println("! Valid modes are only 'pub' or 'sub'.");
                throw new ArgumentParseException();
            }

            // Parse the rest of the arguments
            for (int i = 1; i < argv.length; ++i) { 
                if (argv[i].equals("-h") || argv[i].equals("--help")) {
                    usage();
                    args = null;
                    break;
                }

                if (argv[i].equals("-v") || argv[i].equals("--verbose")) {
                    ++args.verbose;
                    continue;
                }

                if (argv[i].equals("-d") || argv[i].equals("--domain")) {
                    ensureOneMoreArgument(i, argv, "--domain");
                    args.domainId = Integer.parseInt(argv[++i]);
                    if (args.domainId < 0 || 
                            args.domainId > CommandLineArguments.DOMAIN_ID_MAX) {
                        System.err.println(
                                "! Invalid DDS Domain ID:" + args.domainId);
                        System.err.println(
                                "! The domain ID must be between 0 and " +
                                CommandLineArguments.DOMAIN_ID_MAX +
                                " (inclusive)");
                        throw new ArgumentParseException();
                    }
                    continue;
                }

                if (argv[i].equals("-r") || argv[i].equals("--runSeconds")) {
                    ensureOneMoreArgument(i, argv, "--runSeconds");
                    args.runSeconds = Integer.parseInt(argv[++i]);
                    if (args.runSeconds <= 0) {
                        System.err.println(
                            "! Invalid value for --runSeconds argument: " +
                            args.runSeconds);
                    }
                    continue;
                }

                if (argv[i].equals("-f") ||
                        argv[i].equals("--filterExpression")) {
                    ensureOneMoreArgument(i, argv, "--filterExpression");
                    args.contentFilter = argv[++i];
                    continue;
                }

                // Else, is an invalid argument
                System.err.println("! Unknown argument: " + argv[i]);
                throw new ArgumentParseException();
            }
        } catch (ArgumentParseException apx) {
            usage();
            throw apx;
        }
        return args;
    }



    // -----------------------------------------------------------------------
    // Private Methods
    // -----------------------------------------------------------------------

    /**
     * Prints brief instructions on command-line arguments accepted to
     * standard out.
     */
    private static void usage() {
        System.out.println("Usage:");
        System.out.println("    News pub [arguments]     Run as publisher");
        System.out.println("    News sub [arguments]     Run as subscriber");
        System.out.println("Where arguments are:");
        System.out.println(
                "  -h | --help                   " +
                "Shows this page");
        System.out.println(
                "  -v | --verbose                " +
                "Increase output verbosity (can be repeated)");
        System.out.println(
                "  -d | --domain <domainID>      " +
                "Sets the DDS domain ID [default=" + 
                CommandLineArguments.DEFAULT_DOMAIN_ID + "]");
        System.out.println(
                "  -r | --runSeconds <integer>   " +
                "Sets the number of seconds to run [default=20]");
        System.out.println(
                "  -f | --filterExpression <SQL> " +
                "Sets a content filter on the data");
        System.out.println();
    }


    private CommandLineArguments() {
        // empty
    }
    
    
    /**
     * A simple function used to check if there are enough command line
     * arguments.
     */
    private static void ensureOneMoreArgument(
            int i, String [] args, String argName)
    throws ArgumentParseException{
        if (i+1 > args.length) {
            System.out.println("! Error: missing value for " + argName +
                               " argument");
            throw new ArgumentParseException();
        }
    }



    // -----------------------------------------------------------------------
    // Types
    // -----------------------------------------------------------------------

    public static class ArgumentParseException extends Exception {
        // empty
    }

}
