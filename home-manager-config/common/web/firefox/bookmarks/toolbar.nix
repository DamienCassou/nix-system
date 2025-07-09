_:
let
  repos = [
    "Api.Lib"
    "AuditApi"
    "ComputationApi"
    "frontend"
    "ImportApi"
    "IntegrationApi"
    "LedgerApi"
    "monitor"
    "PublicApi"
    "ReferentialApi"
    "ReportApi"
    "UsageApi"
  ];
in
{
  bookmarks = [
    {
      name = "Project (jira)";
      url = "https://jira.wolterskluwer.io/jira/browse/FIN-302";
    }
    {
      name = "Project (confluence)";
      url = "https://confluence.wolterskluwer.io/spaces/TAAEFINSIT/pages/845714815/Merge+EY+agencies+into+one+agency+only";
    }
    {
      name = "mergeable";
      url = "https://github.com/pulls?q=is%3Aopen+is%3Apr+archived%3Afalse+label%3Amergeable+user%3Aforetagsplatsen";
    }
    {
      name = "mine";
      url = "https://github.com/pulls?q=is%3Aopen+is%3Apr+author%3ADamienCassou+archived%3Afalse";
    }
    {
      name = "reviews";
      url = "https://github.com/pulls?q=is%3Aopen+is%3Apr+review-requested%3ADamienCassou+archived%3Afalse";
    }
    {
      name = "Confluence / Jira";
      bookmarks = [
        {
          name = "finsit (confluence)";
          url = "https://confluence.wolterskluwer.io/spaces/TAAEFINSIT/pages/645662150/TAAE+Finsit";
        }
        {
          name = "Bugs";
          url = "https://jira.wolterskluwer.io/jira/browse/FIN-80";
        }
        {
          name = "LHF";
          url = "https://jira.wolterskluwer.io/jira/browse/FIN-67";
        }
        {
          name = "My tasks";
          url = "https://jira.wolterskluwer.io/jira/browse/FIN-150?jql=project%20%3D%20FIN%20AND%20issuetype%20in%20subTaskIssueTypes()%20AND%20status%20in%20(Open%2C%20%22In%20Progress%22%2C%20Waiting%2C%20%22Pull%20Request%22)%20AND%20assignee%20in%20(currentUser())%20order%20by%20lastViewed%20DESC";
        }
      ];
    }
    {
      name = "Github";
      bookmarks = map (repo: {
        name = repo;
        url = "https://github.com/foretagsplatsen/${repo}/pulls";
      }) repos;
    }
  ];
}
