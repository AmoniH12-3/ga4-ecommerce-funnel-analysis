SELECT
  traffic_source.medium AS medium,
  COUNT(DISTINCT IF(event_name = 'session_start',  user_pseudo_id, NULL)) AS visitors,
  COUNT(DISTINCT IF(event_name = 'view_item',      user_pseudo_id, NULL)) AS viewed_item,
  COUNT(DISTINCT IF(event_name = 'add_to_cart',    user_pseudo_id, NULL)) AS added_to_cart,
  COUNT(DISTINCT IF(event_name = 'begin_checkout', user_pseudo_id, NULL)) AS began_checkout,
  COUNT(DISTINCT IF(event_name = 'purchase',       user_pseudo_id, NULL)) AS purchased,
  ROUND(100 * SAFE_DIVIDE(
    COUNT(DISTINCT IF(event_name = 'purchase', user_pseudo_id, NULL)),
    COUNT(DISTINCT IF(event_name = 'session_start', user_pseudo_id, NULL))), 2) AS purchase_rate_pct
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20201101' AND '20210131'
GROUP BY medium
ORDER BY visitors DESC;
