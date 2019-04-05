import { LightningElement, track, wire} from 'lwc';
import getByType from '@salesforce/apex/LeaderboardController.getByType';
export default class Leaderboard extends LightningElement {
  
	@track users;
  @track selected = 'Company';
  @track title = 'Company Leaderboard'

  @wire(getByType, { leaderboard: '$selected' })
  users;  

  get leaderboards() {
    return [
        { label: 'Company Leaderboard', value: 'Company' },
        { label: 'Hackday Leaderboard', value: 'Hackday' },
        { label: 'APAC Leaderboard', value: 'APAC' },
        { label: 'EMEA Leaderboard', value: 'EMEA' },
    ];
  }  

  handleLeaderboardChange(event) {
    this.selected = event.detail.value;
    this.title = this.selected + ' Leaderboard' 
  }  
  
}