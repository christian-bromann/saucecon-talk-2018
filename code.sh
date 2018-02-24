##########
## CLI ###
##########

# go to tmp directory
$ cd Sites/talks/Building\ Scaleable\ And\ Stable\ E2E\ Test\ Suites\ With\ WebdriverIO

# create tmp directory
$ mkdir demo

# install wdio
$ cd demo
$ npm i webdriverio

# generate config file
$ ./node_modules/.bin/wdio

# open atom
$ atom .

###############################
## Configuration Management ###
###############################
# go through config properties

################
## Assertion ###
################

# write a test file
const assert = require('assert')

describe('saucecon test', () => {
    it('should check the title', () => {
        browser.url('/')
        
        const title = browser.getTitle()
        assert.equal(title, 'Saucecon 2018')
    })
})

# add npm script
$ npm init --yes
# "scripts": {
#    "test": "wdio wdio.conf.js"
#  },

# ==> explain page objects (next slide)

# page.js
export default class Page {
    open () {
        browser.url('/')
    }
    
    get title () {
        return browser.getTitle()
    }
}

# saucecon.page.js
class SauceCon extends Page {
}
export default new SauceCon()

# change test to
import assert from 'assert'
import SauceCon from './page_objects/saucecon.page'

describe('saucecon test', () => {
    it('should check the title', () => {
        SauceCon.open()
        assert.equal(SauceCon.title, 'SauceCon 2018')
    })
})

##################
## Integration ###
##################

# install babel
$ npm i babel-preset-es2015 babel-register
# .babelrc
{
    "presets": ["es2015"]
}

# run test, validate that it works
# ==> Split up config files per environment

# ==> How to go about creating a test
$ chromedriver --port=4444 --url-base=/wd/hub --verbose
$ node_modules/.bin/wdio repl chrome

################
## Debugging ###
################

# test around and then show off DevTools example
# ==> Debugging
# show case debug command again
browser.debug()
# add mochaOpts timeout
# switch to DevTools debugging
execArgv: ['--inspect'],
# open devtools in browser and switch to node

# test protocol:
browser.url("http://saucecon.com")


# ==> test collapse/expand of the tabs
import Page from './page'

class SauceCon extends Page {
    /**
     * elements
     */
    get workshopTab () { return $('.et_pb_section_3') }
    get workshopContent () { return $('.et_pb_section_5') }
    
    /**
     * methods
     */
    openWorkshopTab () {
        this.workshopTab.click()
        this.workshopContent.waitForVisible(2000)
    }
}

export default new SauceCon()

# test changes to
it('should allow to open workshop tab', () => {
    SauceCon.openWorkshopTab()
})

################
## Reporters ###
################

# ==> Reporter Show cases
# add allure reporter and reporter options
reporters: ['spec', 'allure'],
reporterOptions: {
    allure: {
        outputDir: './reports'
    }
},

#################
## Test Hooks ###
#################

# run code, install Allure command-line tool to generate the page
$ npm install allure-commandline

# add to onComplete hook to autogenerate page
onComplete: function(exitCode, config, capabilities) {
    var generation = allure(['generate', 'reports'])
    return new Promise((resolve) => generation.on('exit', resolve))
}