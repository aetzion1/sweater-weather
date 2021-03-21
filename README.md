
<!-- PROJECT SHIELDS -->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]



<!-- PROJECT LOGO -->
<br />
<p align="center">
  <!-- <a href="https://github.com/aetzion1/sweater-weather">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a> -->

  <h3 align="center">Sweater Weather</h3>

  <p align="center">
    Sweater Weather is an application that allows users to plan road trips, mainly by providing access to the current weather as well as the forecasted weather at their destination.
    This is the back-end component of a service-oriented architecture. The front-end communicates with this back-end via an API. This repository exposes that API to meet the front-end requirements.
    <br />
    <a href="https://github.com/aetzion1/sweater-weather"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/aetzion1/sweater-weather/issues">Report Bug</a>
    ·
    <a href="https://github.com/aetzion1/sweater-weather/issues">Request Feature</a>
  </p>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
        <li><a href="#learning-goals">Learning Goals</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

Sweater Weather is an application that allows users to plan road trips, mainly by providing access to the current weather as well as the forecasted weather at their destination.
This is the back-end component of the service-oriented architecture. The front-end communicates with this back-end via an API. This repository exposes that API to meet the front-end requirements.

### Learning Goals

This back-end application was created with the following learning goals in mind:
- [x] Expose an API that aggregates data from multiple external APIs
- [x] Expose an API that requires an authentication token
- [x] Expose an API for CRUD functionality
- [x] Determine completion criteria based on the needs of other developers
- [x] Research, select, and consume an API based on your needs as a developer

### Built With

* [Ruby on Rails](https://rubyonrails.org/)
  * Ruby 2.4.1
  * Rails 5.2.3
* [RSpec]() (version 3.8.2)
* []()

<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running follow these simple steps.

### Prerequisites

* ruby 2.4.1
* rails 5.2.3
* rspec 3.8.2

### Setup

1. Clone the repo
   ```sh
   git clone https://github.com/aetzion1/sweater-weather.git
   ```
2. Install gems
   ```sh
   bundle install
   ```
3. Create and migrate database
  `rails db:create`
  `rails db:migrate`
4. Register for API keys and add to application.yml
  * [MapQuestGeocoding] (https://developer.mapquest.com/documentation/geocoding-api/) Used to get coordinates based on search criteria
  * [OpenWeatherOneCall] (https://openweathermap.org/api/one-call-api) Used to get forecast data based on specific coordinates
  * [Unsplash] (https://unsplash.com/documentation#creating-a-developer-account) Used to pull images based on location query paramters

## Gems worth researchin
* [Faraday](https://github.com/lostisland/faraday)
* [Fast JSON API](https://github.com/Netflix/fast_jsonapi)
* [Webmock] (https://github.com/webmock/webmock)
* [VCR] (https://github.com/vcr/vcr)
* [Figaro] (https://github.com/laserlemon/figaro)

<!-- USAGE EXAMPLES -->
## Usage

### Endpoints
The endpoints utilized to design this applciation can be [found_here](https://backend.turing.io/module3/projects/sweater_weather/requirements)

The [Postman](https://www.postman.com/) service can be used to test the above endpoints locally. You can import the following [pre-built_collection](https://github.com/aetzion1/sweater-weather/blob/main/sweater-weather.postman_collection.json) directly into Postman.

<!-- ROADMAP -->
## Roadmap

See the [open issues](https://github.com/aetzion1/sweater-weather/issues) for a list of proposed features (and known issues).

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request



<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.



<!-- CONTACT -->
## Contact

Adam Etzion - [GitHub](https://github.com/aetzion1/repo/stargazers) - [LinkedIn](https://linkedin.com/in/adametzion)

Project Link: [github.com/aetzion1/sweater-weather](https://github.com/aetzion1/sweater-weather)



<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements

* [MapQuest] (https://developer.mapquest.com/documentation/geocoding-api/)
* [OpenWeather] (https://openweathermap.org/api/one-call-api)
* [Unsplash](https://unsplash.com/documentation#creating-a-developer-account)


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/aetzion1/sweater-weather.svg?style=for-the-badge
[contributors-url]: https://github.com/aetzion1/sweater-weather/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/aetzion1/sweater-weather.svg?style=for-the-badge
[forks-url]: https://github.com/aetzion1/sweater-weather/network/members
[stars-shield]: https://img.shields.io/github/stars/aetzion1/sweater-weather.svg?style=for-the-badge
[stars-url]: https://github.com/aetzion1/sweater-weather/stargazers
[issues-shield]: https://img.shields.io/github/issues/aetzion1/sweater-weather.svg?style=for-the-badge
[issues-url]: https://github.com/aetzion1/sweater-weather/issues
[license-shield]: https://img.shields.io/github/license/aetzion1/sweater-weather.svg?style=for-the-badge
[license-url]: https://github.com/aetzion1/sweater-weather/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/adametzion
