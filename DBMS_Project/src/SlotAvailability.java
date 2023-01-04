import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Scanner;

public class SlotAvailability {

  private Scanner scanner;

  public void prompts(Connection connection) {
    scanner = new Scanner(System.in);

    boolean invalidInput = true;
    while (invalidInput) {
      System.out.println("Would you like to know slot availability at one of " +
              "our garages? Enter Y or N:");
      if (scanner.hasNext()) {
        String input = scanner.nextLine();
        if (input.toUpperCase(Locale.ROOT).equals("Y")) {
          invalidInput = false;
          processSlotAvailability(connection);
        } else if (input.toUpperCase(Locale.ROOT).equals("N")) {
          invalidInput = false;
          return;
        } else {
          System.out.println("Invalid input, please try again");
        }
      }
    }
  }

  private void processSlotAvailability(Connection connection) {
    // get list of garages
    // get valid garage
    // send it to db to find out if slot is available

    List<String> garages = getGarages(connection);

    boolean invalidInput = true;
    while (invalidInput) {
      System.out.println("Please enter a garage name: ");
      if (scanner.hasNext()) {
        String input = scanner.nextLine();

        if (garages.contains(input)) {
          invalidInput = false;
          boolean slotAvailable = isSlotAvailable(connection, input);
          if (slotAvailable) {
            System.out.println("Slot is available");
          } else {
            System.out.println("Slot is not available");
          }
        } else {
          System.out.println("Invalid name, please try again");
        }
      }
    }
  }

  private boolean isSlotAvailable(Connection connection, String input) {
    String sql = "{? = call isSlotAvailable(?)}";

    try {
      CallableStatement cs = connection.prepareCall(sql);
      cs.setString(2, input);
      ResultSet resultSet = cs.executeQuery();

      while (resultSet.next()) {
        return resultSet.getBoolean(1);
      }
    } catch (SQLException e) {
      System.out.println(e.getLocalizedMessage());
    }

    return false;
  }

  private List<String> getGarages(Connection connection) {
    List<String> result = new ArrayList<>();
    String sqlStatement = "select parking_garage_name from Parking_Garage";

    try {
      PreparedStatement preparedStatement = connection.prepareStatement(sqlStatement);
      ResultSet resultSet = preparedStatement.executeQuery();

      while (resultSet.next()) {
        result.add(resultSet.getString(1));
      }
    } catch (SQLException e) {
      System.out.println(e.getLocalizedMessage());
    }

    return result;
  }

}
