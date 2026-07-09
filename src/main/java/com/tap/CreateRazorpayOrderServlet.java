package com.tap;

import java.io.IOException;

import org.json.JSONObject;

import com.razorpay.Order;
import com.razorpay.RazorpayClient;
import com.tap.utility.RazorpayConfig;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/createOrder")
public class CreateRazorpayOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        try {

            double amount = (Double) req.getSession()
                                        .getAttribute("finalAmount");

            RazorpayClient client =
                    new RazorpayClient(
                            RazorpayConfig.KEY_ID,
                            RazorpayConfig.KEY_SECRET);

            JSONObject orderRequest = new JSONObject();

            orderRequest.put("amount", (int)(amount * 100));
            orderRequest.put("currency", "INR");
            orderRequest.put("receipt",
                    "receipt_" + System.currentTimeMillis());

            Order order = client.orders.create(orderRequest);

            resp.setContentType("application/json");
            resp.getWriter().print(order.toString());

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}