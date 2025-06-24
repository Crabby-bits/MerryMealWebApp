package com.servlet;

import com.dao.DeliveryDAO;
import com.models.Delivery;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/DeliveryProgress")
public class DeliveryProgressServlet extends HttpServlet {

    private DeliveryDAO deliveryDAO;

    @Override
    public void init() throws ServletException {
        deliveryDAO = new DeliveryDAO(); // Make sure DAO is working
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Delivery> deliveries = deliveryDAO.getAllDeliveries();

        // Attach the list to the request scope
        request.setAttribute("deliveryList", deliveries);

        // Forward to JSP
        request.getRequestDispatcher("DeliveryProgress.jsp").forward(request, response);
    }
}
