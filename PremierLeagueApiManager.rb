class PremierLeagueApiManager   
    @key = ""

    def initialize
        @key = File.read("mashapeKey.txt")        
    end

    def getTopScorersAsJSON
        apiUrl = "https://heisenbug-premier-league-live-scores-v1.p.mashape.com/api/premierleague/table/scorers";   
        
        response = RestClient::Request.execute(method: :get, url: apiUrl, timeout: 10, headers:{
            "X-Mashape-Key" => @key,
            "Accept" => "application/json"
          })

        return response.body      
    end

    def getTopScorers
        response = getTopScorersAsJSON()        
        return JSON.parse(response.body)       
    end

    def putTopScorers
        response = getTopScorers()

        response['scorers'].each do |s|
            if s == nil
                next
            end
        
            playerName = s["playerName"]
            playerScore = s["goals"]
        
            puts playerName + ": " + playerScore.to_s + "\n"
        end
    end

    def getPremierLeagueTableAsJSON
        apiUrl = "https://heisenbug-premier-league-live-scores-v1.p.mashape.com/api/premierleague/table";   
        
        response = RestClient::Request.execute(method: :get, url: apiUrl, timeout: 10, headers:{
            "X-Mashape-Key" => @key,
            "Accept" => "application/json"
          })

        return response.body   
    end

    def getPremierLeagueTable
        response = getPremierLeagueTableAsJSON()
        return JSON.parse(response)
    end

    def putsPremierLeagueTable
        response = getPremierLeagueTable()
        
        response['records'].each do |r|
            if r == nil
                next
            end
        
            teamName = r["team"]
            teamMatchesPlayed = r["played"]
            teamWins = r["win"]
            teamDraws = r["draw"]
            teamLost = r["loss"]
            teamGoalsFor = r["goalsFor"]
            teamGoalAgainst = r["goalsAgainst"]
            teamPoints = r["points"]
        
            printf("%-20s %s\n", teamName , teamMatchesPlayed.to_s + "\t" + teamWins.to_s + "\t" ++ teamDraws.to_s + "\t" + teamLost.to_s + "\t" + teamGoalsFor.to_s + "\t" + teamGoalAgainst.to_s + "\t" + teamPoints.to_s + "\n")
        end
    end 
end