package com.survey.model;

import java.io.Serializable;
import java.math.BigDecimal;

public class Utility implements Serializable {
    private static final long serialVersionUID = 1L;

    // utility to generate password field in Postgreql User table
    // Substitute Password for for whatever is being used, uncomment the main method, then run as follows from the command line:
    //   javac --release 17 -cp web/WEB-INF/lib/jbcrypt-0.4.jar -d /tmp src/com/survey/model/User.java
    //   java -cp /tmp:web/WEB-INF/lib/jbcrypt-0.4.jar com.survey.model.User
    // The string output to the console is the encrypted password value to use in the database table
    public static void main(String[] args) { System.out.println(org.mindrot.jbcrypt.BCrypt.hashpw("Password1", org.mindrot.jbcrypt.BCrypt.gensalt())); }

}

