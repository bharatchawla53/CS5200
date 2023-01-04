import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class NewCustomer {

  private Scanner scanner;
  private String vehicleNumber;
  private String contactNumber;
  private String registrationDate;
  private String confirmationMessage = "Result set representing update count of 1";

  public int processCustomer(Connection connection) {
    scanner = new Scanner(System.in);

    System.out.println("1. Do you want a permit?");
    System.out.println("2. Do you want to make a prepaid reservation?");
    System.out.println("3. Are you a walk-in customer ?");

    boolean invalidInput = true;
    while (invalidInput) {
      System.out.println("Enter one of the options from the above: ");
      if (scanner.hasNext()) {
        String typeOfReservation = scanner.next();

        if (typeOfReservation != null) {
          if (typeOfReservation.equals("1")) {
            invalidInput = false;
            getCustomerInfo();
            processPermit(connection);
            return 1;
          } else if (typeOfReservation.equals("2")) {
            invalidInput = false;
            getCustomerInfo();
            processPrepaid(connection);
            return 2;
          } else if (typeOfReservation.equals("3")) {
            invalidInput = false;
            getCustomerInfo();
            processWalkIn(connection);
            return 3;
          } else {
            System.out.println("Enter one of the options from the above: ");
          }
        }
      }
    }
    return 0;
  }

  private void getCustomerInfo() {
    System.out.println("Enter your vehicle number: ");
    if (scanner.hasNext()) {
      vehicleNumber = scanner.next();
    }

    System.out.println("Enter your contact number: ");
    if (scanner.hasNext()) {
      contactNumber = scanner.next();
    }

    System.out.println("Enter your vehicle registration date: ");
    if (scanner.hasNext()) {
      registrationDate = scanner.next();
    }
  }

  private void processWalkIn(Connection connection) {
    String sql = "{CALL saveCustomer(?,?,?,?,?)}";

    try {
      CallableStatement cs = connection.prepareCall(sql);
      cs.setString(1, "New");
      cs.setString(2, vehicleNumber);
      cs.setString(3, contactNumber);
      cs.setString(4, registrationDate);
      cs.setString(5, "0");
      ResultSet resultSet = cs.executeQuery();
      if (resultSet.toString().equals(confirmationMessage)) {
        System.out.println("Walk-in user created");
      }
    } catch (SQLException e) {
      System.out.println(e.getLocalizedMessage());
    }
  }

  private void processPrepaid(Connection connection) {
    String sql = "{CALL saveCustomer(?,?,?,?,?)}";

    try {
      CallableStatement cs = connection.prepareCall(sql);
      cs.setString(1, "Prepaid");
      cs.setString(2, vehicleNumber);
      cs.setString(3, contactNumber);
      cs.setString(4, registrationDate);
      cs.setString(5, "0");
      ResultSet resultSet = cs.executeQuery();
      if (resultSet.toString().equals(confirmationMessage)) {
        System.out.println("Prepaid user created");
      }
    } catch (SQLException e) {
      System.out.println(e.getLocalizedMessage());
    }
  }

  private void processPermit(Connection connection) {
    String sql = "{CALL saveCustomer(?,?,?,?,?)}";

    try {
      CallableStatement cs = connection.prepareCall(sql);
      cs.setString(1, "Regular");
      cs.setString(2, vehicleNumber);
      cs.setString(3, contactNumber);
      cs.setString(4, registrationDate);
      cs.setString(5, "1");
      ResultSet resultSet = cs.executeQuery();
      if (resultSet.toString().equals(confirmationMessage)){
        System.out.println("User created");
      }
    } catch (SQLException e) {
      System.out.println(e.getLocalizedMessage());
    }
  }
}
