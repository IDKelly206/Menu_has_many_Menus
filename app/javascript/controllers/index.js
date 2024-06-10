// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

// Eager load all controllers defined in the import map under controllers/**/*_controller
// import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
// eagerLoadControllersFrom("controllers", application)

import RemovalsController from "./removals_controller"
application.register("removals", RemovalsController)

import TurboModalController from "./turbo_modal_controller"
application.register("turbo-modal", TurboModalController)

import CourseTypeRadioSelectorController from "./course_type_radio_selector_controller"
application.register("course-type-radio-selector", CourseTypeRadioSelectorController)

import FetchRecipesTurboController from "./fetch_recipes_turbo_controller"
application.register("fetch-recipes-turbo", FetchRecipesTurboController)

import InfiniteScrollController from "./infinite_scroll_controller"
application.register("infinite-scroll", InfiniteScrollController)

import RefreshFrameController from "./refresh_frame_controller"
application.register("refresh-frame", RefreshFrameController)
