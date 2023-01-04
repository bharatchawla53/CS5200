import java.sql.Connection;
import java.util.Scanner;

public class PMS {

  public static Scanner scanner = new Scanner(System.in);

  public static void main(String[] args) {
    String input = null;

    DbConnection dbConnection = new DbConnection();
    Connection connection = dbConnection.getConnection(scanner);

    boolean isUserOperationSuccessful = true;
    while (isUserOperationSuccessful) {
      printMenu();

      if (scanner.hasNext()) {
        boolean invalidInput = true;
        while (invalidInput) {
          input = scanner.next();
          if (validInput(input)) {
            invalidInput = false;
          }
        }
      }


      switch (input) {
        case "1":
          NewCustomer customer = new NewCustomer();
          customer.processCustomer(connection);
          break;
        case "2":
          DeleteReservation deleteReservation = new DeleteReservation();
          if (deleteReservation.delete(connection)) {
            System.out.println("Reservation cancelled\n");
          }
          break;
        case "3":
          ReadReservation readReservation = new ReadReservation();
          readReservation.prompts(connection);
          break;
        case "4":
          SlotAvailability availability = new SlotAvailability();
          availability.prompts(connection);
          break;
        case "5":
          UpdateSlot updateSlot = new UpdateSlot();
          updateSlot.prompts(connection);
          isUserOperationSuccessful = false;
          break;
      }

    }

  }

  private static boolean validInput(String input) {
    if (input.length() == 1) {
      return Character.isDigit(input.charAt(0));
    } else {
      System.out.println("Invalid input, please enter a valid option: ");
    }
    return false;
  }

  private static void printMenu() {
    System.out.println("1. Would you like to create a new user? ");
    System.out.println("2. Would you like to cancel a prepaid reservation? ");
    System.out.println("3. Would you like to view reservation? ");
    System.out.println("4. Would you like to check if slot is available? ");
    System.out.println("5. Would you like to exit the garage? ");
    System.out.println("Enter an option from the above: ");
  }

}
