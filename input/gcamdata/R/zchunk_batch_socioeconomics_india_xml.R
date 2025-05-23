#' module_gcamindia_batch_socioeconomics_xml
#'
#' Construct XML data structure for \code{socioeconomics_india.xml}.
#'
#' @param command API command to execute
#' @param ... other optional parameters, depending on command
#' @return Depends on \code{command}: either a vector of required inputs,
#' a vector of output names, or (if \code{command} is "MAKE") all
#' the generated outputs: \code{socioeconomics_india.xml}.
#' @author AM Nov20

module_gcamindia_batch_socioeconomics_xml <- function(command, ...) {
  if(command == driver.DECLARE_INPUTS) {
    return(c("L201.Pop_GCAMINDIA",
             "L201.BaseGDP_GCAMINDIA",
             "L201.LaborForceFillout_GCAMINDIA",
             FILE = "gcam-india/L201.LaborProductivity_GCAMINDIA"))
  } else if(command == driver.DECLARE_OUTPUTS) {
    return(c(XML = "socioeconomics_india.xml"))
  } else if(command == driver.MAKE) {

    all_data <- list(...)[[1]]

    # Load required inputs
    L201.Pop_GCAMINDIA <- get_data(all_data, "L201.Pop_GCAMINDIA")
    L201.BaseGDP_GCAMINDIA <- get_data(all_data, "L201.BaseGDP_GCAMINDIA")
    L201.LaborForceFillout_GCAMINDIA <- get_data(all_data, "L201.LaborForceFillout_GCAMINDIA")
    L201.LaborProductivity_GCAMINDIA <- get_data(all_data, "gcam-india/L201.LaborProductivity_GCAMINDIA")

    # ===================================================

    # Produce outputs
    create_xml("socioeconomics_india.xml") %>%
      add_xml_data(L201.Pop_GCAMINDIA, "Pop") %>%
      add_xml_data(L201.BaseGDP_GCAMINDIA, "BaseGDP") %>%
      add_xml_data(L201.LaborForceFillout_GCAMINDIA, "LaborForce") %>%
      add_xml_data(L201.LaborProductivity_GCAMINDIA, "LaborProductivity") %>%
      add_precursors("L201.Pop_GCAMINDIA", "L201.BaseGDP_GCAMINDIA", "L201.LaborForceFillout_GCAMINDIA", "gcam-india/L201.LaborProductivity_GCAMINDIA") ->
      socioeconomics_india.xml

    return_data(socioeconomics_india.xml)
  } else {
    stop("Unknown command")
  }
}
