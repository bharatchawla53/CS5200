import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Scanner;

public class DbConnection {
  private java.sql.Connection connection;
  private String user = null;
  private String password = null;

  public java.sql.Connection getConnection(Scanner scanner) {
    System.out.println("Enter username for garage DB : ");
    if (scanner.hasNext()) {
      user = scanner.nextLine();
    }

    System.out.println("Enter password for garage DB : ");
    if (scanner.hasNext()) {
      password = scanner.nextLine();
    }

    try {
      connection = getConnection(user, password);

      if (connection != null) {
        return connection;
      }
    } catch (Exception e) {
      System.out.println("Error : " + e.getLocalizedMessage());
      System.exit(0);
    } /*finally {
      try {
        if (connection != null) {
          connection.close();
        }
      } catch (SQLException e) {
        System.out.println("Error while closing the connection : " + e.getLocalizedMessage());
      }
    }*/
    return null;
  }

  private java.sql.Connection getConnection(String user, String password) throws Exception {
    //Class.forName("com.mysql.cj.jdbc.Driver");
    return DriverManager.getConnection("jdbc:mysql://localhost:3306/garage?", user, password);
  }
}
