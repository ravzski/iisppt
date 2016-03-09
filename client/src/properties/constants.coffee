@DATE_FORMAT = "MMM DD, YYYY"
@TIMESTAMP_FORMAT = "MMM DD, YYYY hh:mm:ss"
@DEFAULT_PER_PAGE = 10
@GMAP_API_KEY = "AIzaSyDl3IaifrpvXFz5UCeE4rqwhWdII-tycsk"

@FACILITY_TYPES = [
  {
    label: 'Train'
    value: 'Train'
  }
  {
    label: 'Bus'
    value: 'Bus'
  }
]

@TRAIN_FACILITIES = [
  {
    label: "LRT 1"
    value: "LRT 1"
  }
  {
    label: "LRT 2"
    value: "LRT 2"
  }
  {
    label: "MRT 1"
    value: "MRT 1"
  }
]

@BUS_FACILITIES = [
  {
    label: "BUS Co. X"
    value: "BUS Co. X"
  }
  {
    label: "BUS Co. Y"
    value: "BUS Co. Y"
  }
]


@INFO_TYPE = [
  {
    label: 'Crime Details'
    value: 'Crime Details'
  }
  {
    label: 'Traffic Incident'
    value: 'Traffic Incident'
  }
  {
    label: 'Sights and Tourist Spot'
    value: 'Sights and Tourist Spot'
  }
  {
    label: 'Historical Landmark'
    value: 'Historical Landmark'
  }
  {
    label: 'Public Facilities'
    value: 'Public Facilities'
  }
]

@STATUS_COLLECTION_ALL= [
  {
    label: 'All'
    value: ''
  }
  {
    label: 'Active'
    value: 'true'
  }
  {
    label: 'Inactive'
    value: 'false'
  }

]


@STATUS_COLLECTION= [
  {
    label: 'Active'
    value: 'true'
  }
  {
    label: 'Inactive'
    value: 'false'
  }

]


@MONTHS = [
  {key: "1", value: "January"},
  {key: "2", value: "Feburary"},
  {key: "3", value: "March"},
  {key: "4", value: "April"},
  {key: "5", value: "May"},
  {key: "6", value: "June"},
  {key: "7", value: "July"},
  {key: "8", value: "Augugust"},
  {key: "9", value: "September"},
  {key: "10", value: "October"},
  {key: "11", value: "November"},
  {key: "12", value: "December"}
]

@MESSAGES =
  UPDATE_SUCCESS: "Updated successfully"
  UPDATE_ERROR: "Update error"
  CREATE_SUCCESS: "Created successfully"
  DELETE_SUCCESS: "Deleted successfully"
  INTERNAL_SERVER_ERROR: "Error 500, internal server error"
  BAD_REQUEST: "Error 400, bad request"
  FORM_ERROR: "Marked fields are blank or have invalid value"
  INVALID_CREDS: "Invalid username or password"
  NO_DATA: "No more data to get"
  INVALID_FILE_SIZE: "File should be less than 10 mb"
  TIMEOUT: "Connection has timed out"
  LOGIN_SUCCESS: "Login success"
  LOGOUT_SUCCESS: "Logout success"
  NO_DATA: "No more data to get"
  NEW_NOTIFICATION: "New Notification"
  PASSWORD_NOT_MATCH: "Password did not match"
  INVALID_EMAIL: "Invalid Email"
  MUST_BE_LOGGED_IN: "You must login to rate"

@DELETE_WARNING = {
    title: 'Are you sure?'
    text: 'You will not be able to recover this data'
    type: 'warning'
    showCancelButton: true
    confirmButtonColor: '#ff604f'
    confirmButtonText: 'Yes, delete it!'
    closeOnCancel: true
    closeOnConfirm: true
    animation: false
  }

@UPDATE_WARNING = {
    title: 'Are you sure?'
    text: 'Make sure all data are correct'
    type: 'warning'
    showCancelButton: true
    confirmButtonColor: '#FCC44D'
    confirmButtonText: 'Yes, update it!'
    closeOnCancel: true
    closeOnConfirm: true
    animation: false
  }
