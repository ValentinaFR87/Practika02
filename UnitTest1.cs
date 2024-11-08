using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using Practica02;


namespace UnitTestProject1
{
    [TestClass]
    public class UnitTest1
    {
        private Form1 form;

        private Authenticator authenticator;

        [TestInitialize]
        public void Setup()
        {
            authenticator = new Authenticator();
        }
        public bool AreAllFieldsFilled(string field1, string field2, string field3, string field4, string field5)
        {
            return !string.IsNullOrWhiteSpace(field1) &&
                   !string.IsNullOrWhiteSpace(field2) &&
                   !string.IsNullOrWhiteSpace(field3) &&
                   !string.IsNullOrWhiteSpace(field4) &&
                   !string.IsNullOrWhiteSpace(field5);
        }

        [TestMethod]
        public void TestClientAuthentication()
        {
            // Подставьте реальные значения логина и пароля для клиента
            string login = "jane.roe@example.com";
            string password = "password222";

            string actualRole = authenticator.AuthenticateUser(login, password);

            Assert.AreEqual("Client", actualRole);
        }
        [TestMethod]
        public void TestEmployeeAuthentication()
        {
            // Подставьте реальные значения логина и пароля для сотрудника
            string login = "eva.adams@example.com";
            string password = "password321";

            string actualRole = authenticator.AuthenticateUser(login, password);

            Assert.AreEqual("Employee", actualRole);
        }

        [TestMethod]
        public void TestSupervisorAuthentication()
        {
            // Подставьте реальные значения логина и пароля для супервизора
            string login = "alice.smirnova@example.com";
            string password = "password123";

            string actualRole = authenticator.AuthenticateUser(login, password);

            Assert.AreEqual("Supervisor", actualRole);
        }

        [TestMethod]
        public void TestInvalidAuthentication()//проверяет случай с неверными данными
        {
            string login = "invalid@example.com";
            string password = "wrongPassword";

            string actualRole = authenticator.AuthenticateUser(login, password);

            Assert.IsNull(actualRole, "Проверка подлинности должна завершиться ошибкой из-за неверных учетных данных");
        }

        [TestMethod]
        [ExpectedException(typeof(ArgumentException))]
        public void TestEmptyLoginOrPassword()//выдает исключение при пустых значениях
        {
            authenticator.AuthenticateUser("", "");
        }

        [TestMethod]
        public void AllFieldsFilled_ReturnsTrue()
        {
            // Arrange
            string field1 = "Джон Доу";
            string field2 = "john.doe@example.com";
            string field3 = "Ул. Лиственная, 123";
            string field4 = "1985-07-18";
            string field5 = "password111";

            // Act
            bool result = AreAllFieldsFilled(field1, field2, field3, field4, field5);

            // Assert
            Assert.IsTrue(result);
        }

        [TestMethod]
        public void MissingField_ReturnsFalse()
        {
            // Arrange
            string field1 = "Джон Доу";
            string field2 = "";
            string field3 = "Ул. Лиственная, 123";
            string field4 = "1985-07-18";
            string field5 = "password111";

            // Act
            bool result = AreAllFieldsFilled(field1, field2, field3, field4, field5);

            // Assert
            Assert.IsFalse(result);
        }

        [TestMethod]
        public void TestReturnsTrue()
        {
            // Arrange
            var validator = new ClientValidator();

            string name = "Джон Доу";
            string email = "john.doe@example.com";
            string address = "Ул. Лиственная, 123";
            string phone = "1985-07-18";
            string password = "password111";

            // Act
            bool result = validator.AreAllFieldsFilled(name, email, address, phone, password);

            // Assert
            Assert.IsTrue(result);
        }

        [TestMethod]
        public void Test_ReturnsFalse()
        {
            // Arrange
            var validator = new ClientValidator();

            string name = "Джон Доу";
            string email = "";
            string address = "Ул. Лиственная, 123";
            string phone = "1985-07-18";
            string password = "password111";

            // Act
            bool result = validator.AreAllFieldsFilled(name, email, address, phone, password);

            // Assert
            Assert.IsFalse(result);
        }
        [TestMethod]
        public void UniqueClient_ReturnsTrue()
        {
            // Arrange
            var validator = new ClientValidator();
            string uniqueEmail = "john.doe@gmail.com";
            string uniquePhone = "1985-07-18";

            // Act
            bool result = validator.IsClientUnique(uniqueEmail, uniquePhone);

            // Assert
            Assert.IsTrue(result);
        }

        [TestMethod]
        public void DuplicateClient_ReturnsFalse()
        {
            // Arrange
            var validator = new ClientValidator();
            string duplicateEmail = "richard.miles@example.com";
            string duplicatePhone = "password333";

            // Act
            bool result = validator.IsClientUnique(duplicateEmail, duplicatePhone);

            // Assert
            Assert.IsFalse(result);
        }

        [TestMethod]
        public void DeleteClient()
        {
            // Arrange
            string phone = "901-234-5678";
            string email = "richard.miles@example.com";
            string message;
            var validator = new ClientValidator();

            // Act
            bool result = validator.DeleteClient(phone, email, out message);

            // Assert
            Assert.IsTrue(result);
            Assert.AreEqual("Клиент успешно удален.", message);
        }
    }
}

