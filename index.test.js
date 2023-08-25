// __tests__/handler.test.js
const { handler } = require("./index");
describe("handler", () => {
  test("should return a valid response", async () => {
    const event = {}; // You can customize the event object if needed
    const result = await handler(event);

    expect(result).toEqual({
      statusCode: 200,
      body: JSON.stringify(
        {
          message: "Your function executed successfully!",
        },
        null,
        2
      ),
    });
  });
});