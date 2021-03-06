React         = require('react')
College       = require('components/blocks/college')
Deadline      = require('components/blocks/deadline')
Military      = require('components/blocks/military')
MoreInfo      = require('components/blocks/moreInfo')
Offices       = require('components/widgets/officesWidget')
PollPlace     = require('components/widgets/pollPlaceWidget')
Share         = require('components/widgets/shareWidget')
entity        = require('utils/entity')
Sticky        = require('react-stickynode')
Scroll        = require('react-scroll')
Reminder      = require('components/widgets/reminderWidget')
ReactTooltip  = require("react-tooltip")
AddToCal      = require('components/widgets/addToCalWidget')
StateInfo     = require('components/blocks/stateInfo')
ShareBar      = require('components/blocks/shareBar')
Reactable     = require('reactable')
VoteLocations = require('data/caLocations')
$             = require('jquery')

module.exports = React.createClass
  displayName: 'CA State Info'

  componentDidMount: ->
    $('.show-locations').on 'click': (e) ->
      e.preventDefault()
      $('.vote-locations').toggleClass 'expanded'
      $(this).toggleClass 'expanded'

      if $(this).hasClass 'expanded'
        $(this).text 'Hide Early Vote Locations'
      else
        $(this).text 'Show Early Vote Locations'


  render: ->
    Table = Reactable.Table
    Thead = Reactable.Thead
    Th = Reactable.Th
    Tr = Reactable.Tr
    Td = Reactable.Td

    <section className='flex ca'>
      <StateInfo {...@props} />
      <ShareBar {...@props} />

      <div className='info-nav'>
        <Sticky top={0} bottomBoundary='section.flex'>
          <ul>
            {if @props.state.pollWgt
              <li>
                <Scroll.Link activeClass='active' to='polling-location' spy=true smooth=true offset=0>
                  <h3 className='caps'>Find Polling Location</h3>
                </Scroll.Link>
              </li>
            }
            <li>
              <Scroll.Link activeClass='active' to='key-info' spy=true smooth=true offset=0>
                <h3 className='caps'>Key Information</h3>
              </Scroll.Link>
            </li>
            <li>
              <Scroll.Link activeClass='active' to='election-day' spy=true smooth=true offset=0>
                <h3 className='caps'>Election Day Voting</h3>
              </Scroll.Link>
            </li>
            <li>
              <Scroll.Link activeClass='active' to='early-voting' spy=true smooth=true offset=0>
                <h3 className='caps'>Early & Absentee Voting</h3>
              </Scroll.Link>
            </li>
            <li>
              <Scroll.Link activeClass='active' to='no-party' spy=true smooth=true offset=0>
                <h3 className='caps'>No Party Preference</h3>
              </Scroll.Link>
            </li>
            <li>
              <Scroll.Link activeClass='active' to='other-parties' spy=true smooth=true offset=0>
                <h3 className='caps'>Other Party Affiliates</h3>
              </Scroll.Link>
            </li>
            <li>
              <Scroll.Link activeClass='active' to='college' spy=true smooth=true offset=0>
                <h3 className='caps'>College Students</h3>
              </Scroll.Link>
            </li>
            <li>
              <Scroll.Link activeClass='active' to='military' spy=true smooth=true offset=0>
                <h3 className='caps'>Military/Overseas Voters</h3>
              </Scroll.Link>
            </li>
            <li>
              <Scroll.Link activeClass='active' to='more-info' spy=true smooth=true offset=0>
                <h3 className='caps'>More Information</h3>
              </Scroll.Link>
            </li>
            <li>
              <Scroll.Link activeClass='active' to='campaign-offices' spy=true smooth=true offset=0>
                <h3 className='caps'>Campaign Offices</h3>
              </Scroll.Link>
            </li>
          </ul>
        </Sticky>
      </div>

      <div className='left'>
        <PollPlace state={@props.state} />

        <div className='info'>
          <div id='key-info' className='key-info section expanded'>
            <div className='section-header'>
              <h3 className='caps'>Key Information</h3>
            </div>

            <div className='section-body'>
              <p>
                The California Democratic Primary takes place on June 7, 2016, and voters must have registered as a Democrat or No Party Preference voter by May 23, 2016 in order to participate.
              </p>

              <p>
                If you are an independent, make sure you're registered as No Party Preference. There is an “American Independent” party in California which is not eligible to vote for Bernie — only Democrats and No Party Preference voters can. If you are registered No Party Preference, ask for a Democratic ballot when you go to vote and you’re all set!
              </p>
            </div>
          </div>

          <div id='election-day' className='section'>
            <div className='section-header'>
              <h3 className='caps'>Election Day Voting</h3>
            </div>

            <div className='section-body'>
              <p>
                After finding <Scroll.Link activeClass='active' to='polling-location' spy=true smooth=true offset=0> your polling location </Scroll.Link> above, you can vote for Bernie on election day, June 7th, 2016, any time from 7:00 a.m. to 8:00 p.m.
              </p>

              <ul>
                <li>If you are a Democrat and have received a vote by mail ballot, you can bring your ballot to any polling location in your county to drop it off.</li>
                <li>If you are a No Party Preference voter and have received a nonpartisan vote by mail ballot, bring your blank ballot to your polling location and exchange it for a Democratic crossover ballot.</li>
                <li>If you have lost your ballot or have not received one, you can go to any polling location and vote by provisional ballot.</li>
              </ul>

              <p>
                If you have any questions about voting in California, call the Bernie Voter Hotline at <a href="tel:14157958065">(415) 795-8065</a>, or email us at <a href="mailto:cavoterprotection@berniesanders.com">cavoterprotection@berniesanders.com</a>.
              </p>
            </div>
          </div>

          <div id='early-voting'>
            <div className='section'>
              <div className='section-header'>
                <h3 className='caps'>Early & Absentee Voting</h3>
              </div>

              <div className='section-body'>

                <div className='btn btn-secondary show-locations'>Show Early Vote Locations</div>

                <div className='vote-locations'>

                  <Table className='table ca-locations' sortable={['county']} filterable={['county', 'address']} filterPlaceholder="Search by County..." noDataText="No matching counties found." itemsPerPage={10} pageButtonLimit={3}>
                    <Thead>
                      <Th column="county">
                        County
                      </Th>
                      <Th column="address">
                        Address
                      </Th>
                      <Th column="phone">
                        Phone
                      </Th>
                      <Th column="hours">
                        Hours
                      </Th>
                    </Thead>
                    {for location in VoteLocations
                      <Tr key={location.Address}>
                        <Td column='county' className='county' data={location.County} />

                        <Td column='address' className='address'>
                          <a href="https://maps.google.com/?q=#{encodeURIComponent(location.Address)}">{location.Address}</a>
                        </Td>

                        {if location.Phone.match(/[a-z]/i)
                          <Td column='phone' className='phone'>{location.Phone}</Td>
                        else if location.Phone.match(/[\n]/)
                          phoneArray = []
                          for phone in location.Phone.split(/\n/)
                            phoneArray.push phone

                          <Td column='phone' className='phone'>
                            {phoneArray.join("\n")}
                          </Td>
                        else
                          <Td column='phone' className='phone'><a href="tel:#{'1' + location.Phone.replace(/[()-\s]/g, '')}">{location.Phone}</a></Td>
                        }

                        <Td column='hours' className='hours' data={location.Hours}>{location.Hours}</Td>
                      </Tr>
                    }
                  </Table>

                </div>

                <p>
                  In California, early voting is underway. There are two types of early voting:
                </p>
                <ol>
                  <li>
                    <strong>In person:</strong> Voters can walk into an early voting location before the primary to cast their ballot. CA has at least one early vote location per county, usually the county registrar’s office. Click the "Show Early Vote Locations" button above to find your early vote location.
                  </li>
                  <li>
                    <strong>Vote-by-mail</strong>: Vote-by-mail ballots that are returned by mail must be postmarked by June 7th and received by June 10th. If you drop off your VBM ballot, you must do so by 8pm on June 7th; you can drop it off at any polling location in your county. You can still request a vote by mail ballot in person at any early vote location in your county, or have someone bring in your VBM application if you can’t get to the polls yourself.
                  </li>
                </ol>
                <p>
                   Contact your <a href="http://www.sos.ca.gov/elections/voting-resources/county-elections-offices/">county elections office</a> to learn more about early voting in your county.
                </p>
              </div>
            </div>

            <div className='section'>
              <div className='section-header'>
                <h3 className='caps'>Do vote-by-mail voters have to vote by mail?</h3>
              </div>

              <div className='section-body'>
                <p>
                  No! If you requested a vote by mail ballot, but want to vote at the polls, bring your VBM ballot and envelope with you on Election Day. If you don’t have your VBM ballot, you’ll have to vote provisionally, but your vote will count.
                </p>
              </div>
            </div>
          </div>

          <div id='no-party'>
            <div className='section'>
              <div className='section-header'>
                <h3 className='caps'>No Party Preference</h3>
              </div>

              <div className='section-body'>
                <p>
                  No Party Preference, or NPP, is California’s term for an independent or unaffiliated voter, which means the voter declined to affiliate with a party. About a third of California voters are NPP and NPP voters are allowed to vote in the Democratic Presidential Primary.
                </p>

                <p>
                  If you are an NPP signed up to vote by mail, you should have received a ballot by now. If you requested a Democratic ballot, you should see Bernie’s name on it. If you didn’t, don’t worry. You can bring your blank NPP ballot and envelope with you to the polls and exchange it for a Democratic ballot when you arrive at your polling place on Tuesday, June 7, or at any early voting location in your county. If you don’t have your VBM ballot, you’ll have to vote provisionally, but your vote will count.
                </p>

                <p>
                  If you are registered NPP but are not a vote by mail voter, be sure to ask for a Democratic crossover ballot at your polling place on Tuesday, June 7.
                </p>
              </div>
            </div>

            <div className='section' id='other-parties'>
              <div className='section-header'>
                <h3 className='caps'>Other Party Affiliates</h3>
              </div>

              <div className='section-body'>
                <p>
                  You have to be a registered voter of the Democratic or NPP party to vote in the Democratic Presidential Primary.
                </p>
              </div>
            </div>
          </div>

          <div id='college' className='section'>
            <div className='section-header'>
              <h3 className='caps'>College Students</h3>
            </div>

            <div className='section-body'>
              <p>
                If you are a college student not living in your home state, you can vote for Bernie in either your home state or in the state in which you are attending school, as long as you registered by the deadline.
              </p>
            </div>
          </div>

          <div id='military' className='section'>
            <div className='section-header'>
              <h3 className='caps'>Military/Overseas Voters</h3>
            </div>

            <div className='section-body'>
              <p>
                If you are a military voter or a United States citizen living abroad, you are able to <a href='https://www.votefromabroad.org/vote/home.htm' target='_blank'>request a ballot here</a>. As long as you requested a VBM ballot by May 31st, you can return your ballot by fax.
              </p>
            </div>
          </div>

          <div id='more-info' className='section'>
            <div className='section-header'>
              <h3 className='caps'>More Information</h3>
            </div>

            <div className='section-body'>
              <p>
                If you have any questions about voting in California, call the Bernie Voter Hotline at <a href="tel:14157958065">(415) 795-8065</a>, or email us at <a href="mailto:cavoterprotection@berniesanders.com">cavoterprotection@berniesanders.com</a>.
              </p>
            </div>
          </div>

          <Offices {...@props} />
        </div>
      </div>
    </section>
