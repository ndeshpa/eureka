/*
 * #%L
 * Eureka WebApp
 * %%
 * Copyright (C) 2012 - 2013 Emory University
 * %%
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * #L%
 */
package edu.emory.cci.aiw.cvrg.eureka.servlet;

import edu.emory.cci.aiw.cvrg.eureka.common.comm.Destination;
import edu.emory.cci.aiw.cvrg.eureka.common.comm.Job;
import edu.emory.cci.aiw.cvrg.eureka.common.comm.SourceConfigParams;
import edu.emory.cci.aiw.cvrg.eureka.common.comm.SystemElement;
import edu.emory.cci.aiw.cvrg.eureka.common.comm.clients.ClientException;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import edu.emory.cci.aiw.cvrg.eureka.common.comm.clients.ServicesClient;
import edu.emory.cci.aiw.cvrg.eureka.common.entity.SystemProposition.SystemType;
import java.util.ArrayList;
import org.protempa.proposition.interval.Interval.Side;

public class JobListServlet extends HttpServlet {

	@Override
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		String eurekaServicesUrl = req.getSession().getServletContext()
				.getInitParameter("eureka-services-url");
		ServicesClient servicesClient = new ServicesClient(eurekaServicesUrl);

		try {
			List<SourceConfigParams> sourceConfigParams = servicesClient.getSourceConfigParams();
			req.setAttribute("sources", sourceConfigParams);

			List<Destination> destinations = servicesClient.getDestinations();
			req.setAttribute("destinations", destinations);
			List<SystemElement> systemElements = servicesClient.getSystemElements();
			List<SystemElement> dateRangeDataElements = new ArrayList<SystemElement>(systemElements.size());
			for (SystemElement entity : systemElements) {
				if (entity.getSystemType() != SystemType.CONSTANT) {
					dateRangeDataElements.add(entity);
				}
			}
			req.setAttribute("dateRangeDataElements", systemElements);
			req.setAttribute("dateRangeSides", DateRangeSide.values());

			String jobIdStr = req.getParameter("jobId");
			Job job;
			if (jobIdStr != null) {
				Long jobId;
				try {
					jobId = Long.valueOf(jobIdStr);
				} catch (NumberFormatException ex) {
					throw new ServletException("Query parameter jobId must be a long, was " + jobIdStr);
				}
				job = servicesClient.getJob(jobId);
			} else {
				List<Job> jobs = servicesClient.getJobsDesc();
				if (!jobs.isEmpty()) {
					job = jobs.get(0);
				} else {
					job = null;
				}
			}
			if (job != null) {
				req.setAttribute("jobStatus", job.toJobStatus());
			}

			req.getRequestDispatcher("/protected/tool.jsp").forward(req, resp);
		} catch (ClientException ex) {
			throw new ServletException("Error getting job list", ex);
		}

	}
}
